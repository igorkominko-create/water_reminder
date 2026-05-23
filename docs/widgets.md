# Home & Lock Screen widgets

Flutter writes widget data via [`home_widget`](https://pub.dev/packages/home_widget). Keys:

| Key | Type | Description |
|-----|------|-------------|
| `goal_ml` | int | Daily goal |
| `today_ml` | int | Intake today |
| `progress` | double | 0.0–1.0 |

App Group (iOS): `group.com.nexushealthlabs.waterreminder`

## iOS

1. **Apple Developer** → Identifiers → App ID `com.nexushealthlabs.waterreminder` → enable **App Groups** → create `group.com.nexushealthlabs.waterreminder`.
2. Xcode → **File → New → Target → Widget Extension** (name e.g. `WaterWidget`).
3. Enable App Group on **Runner** and **Widget Extension** targets.
4. In the widget SwiftUI view, read `UserDefaults(suiteName: "group.com.nexushealthlabs.waterreminder")` for the keys above.
5. Add widget to **Lock Screen** (circular / rectangular) and **Home Screen** in Widget Gallery.
6. Follow `home_widget` iOS setup: URL scheme / `WidgetCenter` reload (see package README).

## Android

1. Create `WaterWidgetProvider` extending `HomeWidgetProvider` (see `home_widget` Android docs).
2. Register in `AndroidManifest.xml` with `android:label="Water"`.
3. Layout: progress ring + `today_ml` / `goal_ml` text.

## Design direction

- Soft gradient background (`#E8F6FC` → white)
- Large percentage, small “ml left” on lock screen
- Tap widget → opens app (`home_widget` launch URI)

When native targets exist, run the app once and add water — widget should refresh via `WidgetBridge.sync`.
