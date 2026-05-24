# Codemagic CI/CD — Water Reminder

Файл конфігурації: **`codemagic.yaml`** у корені репозиторію.

| Workflow | Тригер | Результат |
|----------|--------|-----------|
| **Water Reminder iOS (IPA + widgets)** | push → `main` | `.ipa` + auto-upload в App Store Connect (`APP_STORE_APPLE_ID=6772597155`) |
| **Water Reminder Android (AAB + APK)** | push → `main` | `.aab` (Play Store) + `.apk` (тест/роздача) |

Перед кожною збіркою виконується **`flutter gen-l10n`** (ARB → Dart).

---

## 1. Підключення репозиторію

1. [codemagic.io](https://codemagic.io) → **Add application** → GitHub → `water_reminder`.
2. У проєкті увімкни **codemagic.yaml** (Settings → Build → Configuration as code).
3. Переконайся, що workflow з yaml видно в списку білдів.

---

## 2. iOS — що завантажити / налаштувати

### Apple Developer (браузер)

| Що | Значення |
|----|----------|
| App Group | `group.com.nexushealthlabs.waterreminder` |
| App ID (додаток) | `com.nexushealthlabs.waterreminder` + App Groups |
| App ID (віджет) | `com.nexushealthlabs.waterreminder.WaterWidget` + App Groups |
| App Store Connect | Запис додатка з тим самим bundle id |

### Codemagic → Integrations

| Налаштування | Опис |
|--------------|------|
| **App Store Connect** | API key (Issuer ID, Key ID, `.p8`). Ім’я інтеграції в yaml: **`SnapBite`** — зміни в `codemagic.yaml`, якщо у тебе інше. |

### Codemagic → Code signing identities (iOS)

| Що | Дія |
|----|-----|
| **Distribution certificate** | Upload або **Fetch from Apple** |
| **Provisioning profiles** | App Store profiles для **обох** bundle id (додаток + extension), з App Group |

У `codemagic.yaml` вказано лише **головний** bundle id (`com.nexushealthlabs.waterreminder`) — це **рядок**, не список. Codemagic автоматично шукає також профілі з `com.nexushealthlabs.waterreminder.*` (віджет).

Або в yaml вже є `ios_signing` — Codemagic підтягне профілі після Fetch, якщо API key підключений.

### Environment variables

У `codemagic.yaml` (workflow **ios-release**):

| Змінна | Значення |
|--------|----------|
| `APP_STORE_APPLE_ID` | `6772597155` (Hydro — Water Reminder) |
| `APP_STORE_CONNECT_ALTOOL_ADDITIONAL_ARGUMENTS` | `--apple-id "6772597155"` |

Build number = останній у ASC + 1.

### Публікація

- Після збірки Codemagic **автоматично завантажує IPA** в App Store Connect (`publishing` → integration **SnapBite**).
- `submit_to_testflight: false` — білд з’являється в **TestFlight → Builds**; beta review увімкни вручну в ASC.
- Обробка Apple: **5–30 хв** після успішного Publishing.

#### Якщо «Publishing failed / Failed to publish … to App Store Connect»

Збірка IPA **може бути успішною** — завантаж файл з **Artifacts** (`water_reminder.ipa`).

1. **App Store Connect** → **My Apps** → є додаток **Water Reminder** з bundle `com.nexushealthlabs.waterreminder`.
2. [developer.apple.com](https://developer.apple.com/account) → **Agreements** — прийми всі нові угоди (Paid Apps / Apple Developer).
3. **Codemagic → Integrations** — API key **SnapBite** з роллю **App Manager**, той самий Team **49MKK942FB**.
4. У логах білда розгорни крок **Publishing** — шукай код помилки:
   - **19** / *Cannot determine the Apple ID from Bundle ID* → додай env (див. нижче).
   - **-22020** / authentication → перевір API key, угоди, retry.
5. **Обхід (найнадійніше для 1-го білда):** завантаж IPA вручну через [Transporter](https://apps.apple.com/app/transporter/id1450874784) (Mac) або **Apple Transporter** на Windows.

**Env-група `water_reminder_ios` у Codemagic:**

| Змінна | Значення |
|--------|----------|
| `APP_STORE_APPLE_ID` | Числовий Apple ID додатка (ASC → App Information) |
| `APP_STORE_CONNECT_ALTOOL_ADDITIONAL_ARGUMENTS` | `--apple-id "ТОЙ_САМИЙ_НОМЕР"` |

Розкоментуй у `codemagic.yaml`: `groups: [water_reminder_ios]`.

Щоб CI був зеленим без auto-upload — тимчасово закоментуй блок `publishing:` у yaml; IPA лишиться в Artifacts.

---

## 3. Android — що завантажити / налаштувати

### Варіант A (рекомендовано): Keystore в UI

**Team settings → Code signing identities → Android keystores**

| Поле | Опис |
|------|------|
| **Reference name** | `water_reminder_release` (має збігатися з yaml) |
| **Keystore file** | `.jks` або `.keystore` |
| **Keystore password** | пароль сховища |
| **Key alias** | alias ключа |
| **Key password** | пароль ключа |

Codemagic автоматично виставить `CM_KEYSTORE_PATH`, `CM_KEYSTORE_PASSWORD`, `CM_KEY_ALIAS`, `CM_KEY_PASSWORD` під час білда.  
`android/app/build.gradle.kts` читає ці змінні.

### Варіант B: Environment variable group

Група **`water_reminder_android`**:

| Змінна | Secret | Опис |
|--------|--------|------|
| `CM_KEYSTORE` | ✅ | Файл keystore у **Base64** (`base64 -i release.jks`) |
| `CM_KEYSTORE_PASSWORD` | ✅ | Пароль keystore |
| `CM_KEY_ALIAS` | ✅ | Alias |
| `CM_KEY_PASSWORD` | ✅ | Пароль ключа |

Розкоментуй у yaml:

```yaml
groups:
  - water_reminder_android
```

Скрипт у білді декодує `CM_KEYSTORE` → `/tmp/keystore.jks`, якщо UI keystore не використовується.

### Google Play (опційно, для auto-upload)

Група **`google_play_credentials`**:

| Змінна | Secret | Опис |
|--------|--------|------|
| `GOOGLE_PLAY_SERVICE_ACCOUNT_CREDENTIALS` | ✅ | JSON service account (Play Console → API access) |

Пакет: `com.ihorkominko.waterreminder`.  
Перший раз AAB краще завантажити вручну в Play Console. Потім розкоментуй `publishing.google_play` у yaml.

---

## 4. Локальна збірка з підписом (Android)

Створи `android/key.properties` (не комітити):

```properties
storePassword=***
keyPassword=***
keyAlias=***
storeFile=../path/to/release.jks
```

---

## 5. Перевірка

```bash
flutter pub get
flutter gen-l10n
flutter test
```

Push у `main` → обидва workflow стартують автоматично.

---

## 6. Типові помилки

| Помилка | Рішення |
|---------|---------|
| No profile for `…WaterWidget` | Fetch signing для **двох** bundle id |
| `CM_KEYSTORE_PATH` missing | Завантаж keystore `water_reminder_release` або групу `water_reminder_android` |
| `AppLocalizations` not found | Переконайся, що крок `flutter gen-l10n` є в логах CI |
| Integration `SnapBite` not found | Перейменуй `app_store_connect:` у yaml або створи інтеграцію з тим ім’ям |

Деталі iOS/віджетів: [codemagic_ios_uk.md](codemagic_ios_uk.md).
