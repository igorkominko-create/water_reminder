import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'ad_unit_ids.dart';

/// Centralizes ATT (iOS), AdMob init, banner, and interstitial lifecycle.
///
/// Apple requires [resolveAppTrackingTransparency] before [MobileAds.instance.initialize].
class AdMobService extends ChangeNotifier {
  AdMobService({this.adsEnabled = true, SharedPreferences? preferences})
    : _preferences = preferences;

  static const _goalCelebrationDayKey = AppConstants.prefGoalCelebrationDay;

  /// Last resolved ATT status on iOS (null until first resolve attempt).
  static TrackingStatus? lastTrackingStatus;

  final bool adsEnabled;
  SharedPreferences? _preferences;

  bool _initialized = false;
  BannerAd? _bannerAd;
  bool _bannerReady = false;

  InterstitialAd? _interstitialAd;
  bool _isLoadingInterstitial = false;
  String? _pendingGoalDayKey;

  bool get isBannerReady => _bannerReady && _bannerAd != null;

  AdWidget? get bannerAdWidget {
    final ad = _bannerAd;
    if (!_bannerReady || ad == null) return null;
    return AdWidget(ad: ad);
  }

  double get bannerHeight => AdSize.banner.height.toDouble();

  /// iOS: resolve ATT before any AdMob SDK call.
  ///
  /// Waits for the system dialog when status is [TrackingStatus.notDetermined],
  /// then returns the user's choice (authorized, denied, or restricted).
  /// Android/other: no-op. Safe to call multiple times (idempotent).
  static Future<TrackingStatus> resolveAppTrackingTransparency() async {
    if (kIsWeb || !Platform.isIOS) {
      lastTrackingStatus = TrackingStatus.notSupported;
      return TrackingStatus.notSupported;
    }

    try {
      var status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        // Blocks until the user taps Allow or Ask App Not to Track.
        status = await AppTrackingTransparency.requestTrackingAuthorization();
      }
      lastTrackingStatus = status;
      if (kDebugMode) {
        debugPrint('ATT resolved: $status');
      }
      return status;
    } catch (e, st) {
      debugPrint('ATT request failed: $e\n$st');
      lastTrackingStatus = TrackingStatus.denied;
      return TrackingStatus.denied;
    }
  }

  /// ATT (iOS) → [MobileAds.instance.initialize] → preload ads.
  Future<void> initialize() async {
    if (!adsEnabled || _initialized) return;

    await resolveAppTrackingTransparency();
    await MobileAds.instance.initialize();
    _initialized = true;
    loadBanner();
    loadInterstitial();
  }

  void loadBanner() {
    if (!adsEnabled || !_initialized) return;

    _bannerAd?.dispose();
    _bannerAd = null;
    _bannerReady = false;
    notifyListeners();

    _bannerAd = BannerAd(
      adUnitId: AdUnitIds.banner,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _bannerReady = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner failed to load: $error');
          ad.dispose();
          if (identical(ad, _bannerAd)) {
            _bannerAd = null;
            _bannerReady = false;
            notifyListeners();
          }
        },
      ),
    )..load();
  }

  void loadInterstitial() {
    if (!adsEnabled || !_initialized || _isLoadingInterstitial) return;
    if (_interstitialAd != null) return;

    _isLoadingInterstitial = true;
    InterstitialAd.load(
      adUnitId: AdUnitIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoadingInterstitial = false;
          _interstitialAd = ad;
          _bindInterstitialCallbacks(ad);
          if (_pendingGoalDayKey != null) {
            _showInterstitialForPendingGoal();
          }
        },
        onAdFailedToLoad: (error) {
          _isLoadingInterstitial = false;
          debugPrint('Interstitial failed to load: $error');
        },
      ),
    );
  }

  /// Call when the user reaches the daily goal for the first time that day.
  Future<void> onGoalReached(String todayKey) async {
    if (!adsEnabled || !_initialized) return;
    if (await _goalInterstitialAlreadyShown(todayKey)) return;

    _pendingGoalDayKey = todayKey;
    final ad = _interstitialAd;
    if (ad != null) {
      await _showInterstitialForPendingGoal();
    } else {
      loadInterstitial();
    }
  }

  Future<bool> _goalInterstitialAlreadyShown(String todayKey) async {
    final prefs = _preferences ??= await SharedPreferences.getInstance();
    return prefs.getString(_goalCelebrationDayKey) == todayKey;
  }

  Future<void> _markGoalInterstitialShown(String todayKey) async {
    final prefs = _preferences ??= await SharedPreferences.getInstance();
    await prefs.setString(_goalCelebrationDayKey, todayKey);
  }

  void _bindInterstitialCallbacks(InterstitialAd ad, {String? goalDayToMark}) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        final day = goalDayToMark;
        if (day != null) {
          _markGoalInterstitialShown(day);
        }
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Interstitial failed to show: $error');
        ad.dispose();
        _interstitialAd = null;
        _pendingGoalDayKey = null;
        loadInterstitial();
      },
    );
  }

  Future<void> _showInterstitialForPendingGoal() async {
    final dayKey = _pendingGoalDayKey;
    final ad = _interstitialAd;
    if (dayKey == null || ad == null) return;
    if (await _goalInterstitialAlreadyShown(dayKey)) {
      _pendingGoalDayKey = null;
      return;
    }

    _pendingGoalDayKey = null;
    _bindInterstitialCallbacks(ad, goalDayToMark: dayKey);
    await ad.show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
