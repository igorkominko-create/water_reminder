# iOS Widget Extension — покрокова інструкція (Water Reminder)

> **Немає Mac?** Збирай IPA на **Codemagic** — див. **[codemagic_ios_uk.md](codemagic_ios_uk.md)**.  
> Нижче — ручне налаштування в Xcode (якщо з’явиться Mac).

Потрібен **платний Apple Developer** (App Groups). Mac потрібен лише для локальної збірки.

## Огляд мосту Flutter ↔ iOS

| Шар | Роль |
|-----|------|
| **Flutter** | `HydrationNotifier` → `WidgetSyncHelper.pushSnapshot()` |
| **home_widget** | Пише в `UserDefaults(suiteName: App Group)` |
| **WidgetKit** | `WaterWidget` читає ті самі ключі і малює SwiftUI |

**App Group ID:** `group.com.nexushealthlabs.waterreminder`  
**Widget `kind` (обов’язково):** `WaterWidget` — збігається з `AppConstants.iosWidgetName` у Dart.

---

## Крок 1 — Apple Developer: App Group

1. [developer.apple.com](https://developer.apple.com/account) → **Certificates, Identifiers & Profiles** → **Identifiers**.
2. **App Groups** → **+** → Identifier:  
   `group.com.nexushealthlabs.waterreminder`
3. **App IDs** → `com.nexushealthlabs.waterreminder` → увімкни **App Groups** → вибери групу вище.
4. Якщо є окремий App ID для extension (`com.nexushealthlabs.waterreminder.WaterWidget`) — теж додай App Group (Xcode може створити його автоматично).

---

## Крок 2 — Xcode: Widget Extension

1. Відкрий **`ios/Runner.xcworkspace`** (не `.xcodeproj`).
2. **File → New → Target…**
3. **Widget Extension** → Next.
4. **Product Name:** `WaterWidgetExtension`  
   **Include Live Activity:** вимкнено  
   **Include Configuration App Intent:** вимкнено  
5. Xcode створить папку з шаблоном — **видали** згенерований `.swift` (залиш Info.plist / Assets якщо треба).
6. Перетягни в target файли з репозиторію **`ios/WaterWidget/`**:
   - `WaterWidget.swift`
   - `WaterWidgetViews.swift`
   - `HydrationWidgetData.swift`
   - `Assets.xcassets`
   - `Info.plist` (або залиш Xcode-шний з `NSExtension` → widgetkit)
7. **Target → WaterWidgetExtension → Build Phases → Compile Sources** — усі 3 `.swift` файли.

---

## Крок 3 — App Groups у Xcode

### Runner (основний додаток)

1. Target **Runner** → **Signing & Capabilities** → **+ Capability** → **App Groups**.
2. Додай: `group.com.nexushealthlabs.waterreminder`  
   (у проєкті вже є `ios/Runner/Runner.entitlements`).

### WaterWidgetExtension

1. Target **WaterWidgetExtension** → **Signing & Capabilities** → **App Groups**.
2. Та сама група: `group.com.nexushealthlabs.waterreminder`  
   (файл `ios/WaterWidgetExtension.entitlements`).

### Deployment Target

- **WaterWidgetExtension** → **General** → **Minimum Deployments: iOS 16.0** (Lock Screen widgets).
- **Runner** можна лишити 13+.

### Bundle ID extension

Зазвичай: `com.nexushealthlabs.waterreminder.WaterWidget`

---

## Крок 4 — Embed extension у Runner

1. Target **Runner** → **General** → **Frameworks, Libraries, and Embedded Content**  
   або **Build Phases → Embed Foundation Extensions**.
2. Має з’явитися **WaterWidgetExtension.appex** (Xcode додає при створенні target).

---

## Крок 5 — Перевір `kind` віджета

У `ios/WaterWidget/WaterWidget.swift`:

```swift
let kind: String = "WaterWidget"
```

У Dart (`lib/core/constants/app_constants.dart`):

```dart
static const String iosWidgetName = 'WaterWidget';
```

Якщо зміниш одне — зміни друге.

---

## Крок 6 — Збірка та тест

```bash
cd water_reminder
flutter pub get
flutter run
```

1. У додатку натисни **+250 ml**.
2. **Home Screen** → довгий тап → **Edit Home Screen** → **+** → **Water** → Small.
3. **Lock Screen** → утримуй екран → **Customize** → Lock Screen → **+** → **Water** → Circular або Rectangular.

Віджет оновлюється одразу після `HomeWidget.updateWidget` (викликається з Flutter при кожному додаванні води).

---

## Ключі UserDefaults (контракт)

| Ключ | Тип | Dart / Swift |
|------|-----|----------------|
| `goal_ml` | int | денна ціль |
| `today_ml` | int | випито сьогодні |
| `progress` | double | 0.0–1.0 |
| `percent` | int | 0–100 |
| `remaining_ml` | int | залишилось |
| `goal_reached` | bool | ціль досягнута |
| `updated_at` | string | ISO8601 |

---

## Типи віджетів (SwiftUI)

| Сімейство | Екран | UI |
|-----------|--------|-----|
| `.systemSmall` | Home | Кільцевий прогрес + % + «ml left» |
| `.accessoryCircular` | Lock Screen | Gauge + крапля |
| `.accessoryRectangular` | Lock Screen | Прогрес-бар + % |

Код: `ios/WaterWidget/WaterWidgetViews.swift`.

---

## Troubleshooting

| Проблема | Рішення |
|----------|---------|
| Віджет 0% завжди | App Group не збігається в Runner і Extension; перевір entitlements |
| `setAppGroupId` error у Flutter | Викликати `initialize()` до `saveWidgetData` (у нас у `main.dart`) |
| Віджет не оновлюється | `kind` ≠ `WaterWidget`; перевір лог після `updateWidget` |
| Немає Lock Screen у галереї | iOS 16+, реальний пристрій, extension deployment ≥ 16 |
| Build cycle / Thin Binary | У Runner Build Phases: **Embed Foundation Extensions** після **Thin Binary** або вимкни sandbox для script (див. home_widget docs) |

---

## Dart (де викликається sync)

- `lib/main.dart` — `widgetSyncRepository.initialize()`
- `lib/features/hydration/application/hydration_notifier.dart` — після `addWater` / `setGoal` / `resetToday`
- `lib/data/widget/widget_sync_helper.dart` — запис + `HomeWidget.updateWidget`

---

## Deep link (опційно)

URL scheme `waterreminder://` додано в `Runner/Info.plist`. Тап по віджету відкриває додаток (`widgetURL` у Swift).
