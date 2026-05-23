# App icon & splash screen

Branding uses **flutter_launcher_icons** and **flutter_native_splash**. Colors match `lib/core/theme/app_theme.dart`.

| Asset | Path | Notes |
|-------|------|--------|
| App icon | `assets/icon.png` | **1024×1024** PNG, square, no rounded corners (OS masks them). |
| Splash logo | `assets/splash_logo.png` | **~512×512** PNG, transparent background, centered droplet/logo only. |

Replace these files with your final art, then regenerate native assets (commands below).

## Generate icons & splash

```bash
cd c:\Users\Ihor\Desktop\primus_app\water_reminder
flutter pub get
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## pubspec.yaml (already configured)

**Launcher icons** — `image_path: assets/icon.png`, adaptive Android background `#0B3D5C`.

**Native splash** — background `#F8FBFD` (app surface), centered `assets/splash_logo.png`, Android 12+ block included.

## First commit workflow

```bash
cd c:\Users\Ihor\Desktop\primus_app\water_reminder
flutter pub get
dart run flutter_launcher_icons
dart run flutter_native_splash:create
dart format .
flutter analyze
flutter test
git status
git add .
git commit -m "chore(branding): add app icon, splash screen, and custom water entry"
git push origin main
```

Review `git status` before `git add .` — do not commit `build/`, `.dart_tool/`, `android/local.properties`, or keystores.
