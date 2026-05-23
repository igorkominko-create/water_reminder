# AdMob setup (Water Reminder)

Uses [google_mobile_ads](https://pub.dev/packages/google_mobile_ads) with **Google test IDs** in debug builds.

## Native configuration

### iOS — `ios/Runner/Info.plist`

| Key | Value (test) |
|-----|----------------|
| `GADApplicationIdentifier` | `ca-app-pub-3940256099942544~1458002511` |
| `NSUserTrackingUsageDescription` | Shown before ATT prompt (iOS 14+) |

ATT is requested in `AdMobService` via `app_tracking_transparency`.

### Android — `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-3940256099942544~3347511713"/>
```

## Dart layout

| File | Role |
|------|------|
| `lib/core/ads/ad_unit_ids.dart` | Test app + ad unit IDs per platform |
| `lib/core/ads/admob_service.dart` | Init, banner, interstitial, goal trigger |
| `lib/features/ads/presentation/home_bottom_banner_ad.dart` | Bottom banner UI |
| `lib/core/di/providers.dart` | `admobServiceProvider` |

## Behaviour

- **Banner:** loads after `AdMobService.initialize()` on home screen; pinned via `bottomNavigationBar`.
- **Interstitial:** preloaded in background; shown **once per calendar day** when the user **first reaches** the daily goal (`HydrationNotifier.addWater`).

## Production

1. Create app in [AdMob console](https://admob.google.com/) for iOS and Android.
2. Replace IDs in `Info.plist`, `AndroidManifest.xml`, and `lib/core/ads/ad_unit_ids.dart`.
3. Add full [SKAdNetwork list](https://developers.google.com/admob/ios/quick-start#update_your_infoplist) to `Info.plist` before release.

**Never ship with test ad unit IDs in production.**
