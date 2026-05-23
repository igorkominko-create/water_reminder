# iOS + віджети без Mac (Codemagic)

Mac **не потрібен**. Збірка йде на серверах Codemagic (macOS). Тестувати віджети можна на **iPhone через TestFlight**.

## Що робить репозиторій

- Swift-код віджетів: `ios/WaterWidget/`
- Скрипт додає target у Xcode-проєкт: `tool/patch_ios_widget_target.py` (запускається в CI)
- `codemagic.yaml` → workflow **Water Reminder iOS (IPA + widgets)**

## 1. Apple Developer (у браузері)

### App Group

1. [Identifiers → App Groups](https://developer.apple.com/account/resources/identifier/list/applicationGroup) → **+**
2. Identifier: `group.com.nexushealthlabs.waterreminder`

### App IDs (2 штуки)

| Bundle ID | App Groups |
|-----------|------------|
| `com.nexushealthlabs.waterreminder` | ✅ група вище |
| `com.nexushealthlabs.waterreminder.WaterWidget` | ✅ та сама група |

Увімкни **App Groups** для обох ID і вибери `group.com.nexushealthlabs.waterreminder`.

### App Store Connect

Створи додаток **Water Reminder** з bundle id `com.nexushealthlabs.waterreminder` (якщо ще немає).

## 2. Codemagic

1. [codemagic.io](https://codemagic.io) → **Add application** → репо `water_reminder`.
2. Увімкни **codemagic.yaml** у налаштуваннях проєкту.
3. **Team settings → Integrations** — той самий ключ App Store Connect, що для SnapBite (`SnapBite` у yaml).
4. **Code signing identities** → **Fetch** (або upload) профілі для:
   - `com.nexushealthlabs.waterreminder`
   - `com.nexushealthlabs.waterreminder.WaterWidget`  
   Обидва мають містити App Group у entitlements.
5. **Start build** → workflow **Water Reminder iOS (IPA + widgets)** → гілка `main`.

## 3. TestFlight на iPhone

1. Після успішного білда — **TestFlight** (запрошення собі як тестеру).
2. Встанови додаток, додай воду в апці.
3. **Home Screen** → довгий тап → **Edit Home Screen** → **+** → **Water**.
4. **Lock Screen** (iOS 16+) → Customize → **+** → **Water** → круглий або прямокутний.

Віджет оновлюється після кожного натискання «+ml» у додатку (Flutter → App Group → WidgetKit).

## 4. Android (без Mac)

Workflow **Water Reminder Android (AAB)** — вручну в Codemagic.  
Потрібен keystore `water_reminder_release` у Codemagic (або зміни ім’я в yaml).

## Troubleshooting

| Помилка | Дія |
|---------|-----|
| No profile for `…WaterWidget` | У Codemagic fetch signing для **обох** bundle id |
| App Group entitlement mismatch | Перевір entitlements у Runner і extension у репо |
| Widget не в IPA | Перевір лог: `WaterWidgetExtension` у xcodebuild; скрипт patch має пройти |
| TestFlight beta review fields | У yaml `submit_to_testflight: true` — заповни Test Information в ASC або постав `false` |

## Локально на Windows

```bash
cd water_reminder
python tool/patch_ios_widget_target.py   # один раз, якщо ще не в CI
flutter test
```

IPA зібрати локально на Windows **не вийде** — лише Codemagic або Mac.
