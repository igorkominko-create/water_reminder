# Native widgets (iOS & Android)

Flutter never draws Lock Screen / Home Screen UI directly. We sync a **shared data contract** from Dart, then native code renders widgets.

## Contract (`WidgetDataKeys`)

| Key | Type | Example |
|-----|------|---------|
| `goal_ml` | int | 2000 |
| `today_ml` | int | 750 |
| `progress` | double | 0.375 |
| `percent` | int | 38 |
| `remaining_ml` | int | 1250 |
| `goal_reached` | bool | false |
| `updated_at` | String (ISO8601) | audit / debug |

**Writer:** `HomeWidgetSyncRepository` (Dart)  
**Readers:** `WaterWidgetProvider` (Android), SwiftUI Widget Extension (iOS, TODO)

App Group (iOS): `group.com.nexushealthlabs.waterreminder`

## Android (implemented)

- `WaterWidgetProvider.kt` — `HomeWidgetProvider` subclass
- `res/layout/water_widget.xml` — minimal premium layout
- Registered in `AndroidManifest.xml`
- After `flutter run`, long-press home screen → Widgets → **Water**

## iOS

Swift sources: `ios/WaterWidget/` (Home + Lock Screen).

**Full setup (Ukrainian):** [ios_widget_setup_uk.md](ios_widget_setup_uk.md)

Quick: Xcode → Widget Extension target → App Group `group.com.nexushealthlabs.waterreminder` → `kind` = `WaterWidget`.

## Tap to open app

Configure URL scheme `waterreminder://` in `Info.plist` (iOS) and intent-filter (Android) when adding quick-add buttons on widgets.
