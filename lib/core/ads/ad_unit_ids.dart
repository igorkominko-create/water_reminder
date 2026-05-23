import 'dart:io';

/// Google AdMob test IDs — replace with production IDs before store release.
/// https://developers.google.com/admob/flutter/test-ads
abstract final class AdUnitIds {
  static String get appId => Platform.isIOS ? _iosAppId : _androidAppId;

  static String get banner => Platform.isIOS ? _iosBanner : _androidBanner;

  static String get interstitial =>
      Platform.isIOS ? _iosInterstitial : _androidInterstitial;

  static const _androidAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const _iosAppId = 'ca-app-pub-3940256099942544~1458002511';

  static const _androidBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _iosBanner = 'ca-app-pub-3940256099942544/2934735716';

  static const _androidInterstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const _iosInterstitial = 'ca-app-pub-3940256099942544/4411468910';
}
