# Water Reminder

Minimal Flutter hydration tracker with a focus on **iOS Lock Screen / Home Screen widgets** and **Android home screen widgets**.

## Project location

`c:\Users\Ihor\Desktop\primus_app\water_reminder`

(Separate from SnapBite — open this folder as its own workspace in Cursor.)

## Bundle IDs (same Apple / Google developer accounts as SnapBite)

| Platform | ID |
|----------|-----|
| iOS | `com.nexushealthlabs.waterreminder` |
| Android | `com.ihorkominko.waterreminder` |

Register new App ID / Play app with these IDs before store release.

## GitHub

Remote (after you create the empty repo on GitHub):

```text
https://github.com/igorkominko-create/water_reminder.git
```

1. Open [github.com/new](https://github.com/new)
2. Repository name: **water_reminder**
3. **Private** (recommended), **do not** add README / .gitignore (already in project)
4. Create repository, then:

```bash
cd water_reminder
git push -u origin main
```

Initial commit on `main`: `8d79111`.

## Run locally

```bash
cd water_reminder
flutter pub get
flutter run
```

## Architecture

Layered **Riverpod + repository** design. Full diagram: **[docs/architecture.md](docs/architecture.md)**.

```
presentation → HydrationNotifier → HydrationRepository / WidgetSyncRepository → prefs + home_widget
```

## What's included (v0.2)

- Premium home UI: gradient, glass cards, animated progress ring, haptic quick-add
- Domain layer (`HydrationSnapshot`, repository contracts)
- Android home screen widget (`WaterWidgetProvider`)
- iOS widget extension scaffold (`ios/WidgetExtension/README.md`)

## Widgets

See **[docs/widgets.md](docs/widgets.md)** for the shared key contract.

**iOS without Mac:** **[docs/codemagic_ios_uk.md](docs/codemagic_ios_uk.md)** — build IPA + widgets on Codemagic, test via TestFlight.

**iOS with Xcode:** **[docs/ios_widget_setup_uk.md](docs/ios_widget_setup_uk.md)**.

## Tests

```bash
flutter test
flutter analyze
```
