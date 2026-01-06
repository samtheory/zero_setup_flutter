# مرحله 2: تنظیم Android Flavors

## مقدمه

در این مرحله Android Flavors را پیکربندی می‌کنیم تا بتوانیم چند نسخه از اپلیکیشن (Development, Staging, Production) را همزمان نصب کنیم.

## اهداف

- ✅ نصب همزمان چند نسخه از اپ
- ✅ نام متفاوت برای هر نسخه
- ✅ آیکون متفاوت برای تشخیص آسان
- ✅ Package name متفاوت
- ✅ مدیریت منابع جداگانه

## ساختار Gradle

```
android/app/
├── build.gradle.kts           # تنظیمات اصلی
└── src/
    ├── main/                  # منابع مشترک
    ├── dev/                   # منابع Development
    ├── staging/               # منابع Staging
    └── prod/                  # منابع Production
```

## 1. پیکربندی build.gradle.kts

### فایل: `android/app/build.gradle.kts`

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.zero_setup_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // این مقدار توسط flavors override می‌شود
        applicationId = "com.example.zero_setup_flutter"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ==================== Build Types ====================
    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("debug")
        }
        
        debug {
            isMinifyEnabled = false
            isDebuggable = true
        }
    }

    // ==================== Product Flavors ====================
    flavorDimensions += "environment"
    
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            
            // نام اپلیکیشن در Manifest
            resValue("string", "app_name", "Zero Setup (Dev)")
            
            // متغیرهای Build Config
            buildConfigField("String", "ENV_NAME", "\"development\"")
            buildConfigField("String", "BASE_URL", "\"https://dev-api.example.com\"")
            buildConfigField("boolean", "SHOW_LOGS", "true")
        }
        
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            
            resValue("string", "app_name", "Zero Setup (Staging)")
            
            buildConfigField("String", "ENV_NAME", "\"staging\"")
            buildConfigField("String", "BASE_URL", "\"https://staging-api.example.com\"")
            buildConfigField("boolean", "SHOW_LOGS", "true")
        }
        
        create("prod") {
            dimension = "environment"
            
            resValue("string", "app_name", "Zero Setup")
            
            buildConfigField("String", "ENV_NAME", "\"production\"")
            buildConfigField("String", "BASE_URL", "\"https://api.example.com\"")
            buildConfigField("boolean", "SHOW_LOGS", "false")
        }
    }
    
    // ==================== Build Variants ====================
    // این تنظیمات ترکیب‌های buildType و flavor را مدیریت می‌کند
    applicationVariants.all {
        val variant = this
        variant.outputs
            .map { it as com.android.build.gradle.internal.api.BaseVariantOutputImpl }
            .forEach { output ->
                // نام فایل APK را سفارشی می‌کنیم
                // مثال: zero-setup-dev-1.0.0-debug.apk
                val appName = "zero-setup"
                val flavorName = variant.flavorName
                val buildType = variant.buildType.name
                val versionName = variant.versionName
                
                output.outputFileName = "${appName}-${flavorName}-${versionName}-${buildType}.apk"
            }
    }
}

flutter {
    source = "../.."
}

// ==================== Dependencies ====================
dependencies {
    // اضافه کردن وابستگی‌های مورد نیاز
}
```

## 2. پیکربندی AndroidManifest.xml

### فایل: `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    
    <application
        android:label="@string/app_name"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <activity
            android:name=".MainActivity"
            android:supportsPictureInPicture="true"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme" />
              
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>

        <!-- Foreground Service -->
        <service
            android:name="com.pravera.flutter_foreground_task.service.ForegroundService"
            android:foregroundServiceType="specialUse"
            android:exported="false">
            <property
                android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE"
                android:value="Driver safety reminders" />
        </service>

        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    
    <queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
    </queries>
</manifest>
```

## 3. ایجاد آیکون‌های متفاوت

### ساختار پوشه‌ها

```
android/app/src/
├── dev/
│   └── res/
│       └── mipmap-*/
│           └── ic_launcher.png  (آیکون آبی برای Dev)
├── staging/
│   └── res/
│       └── mipmap-*/
│           └── ic_launcher.png  (آیکون نارنجی برای Staging)
└── prod/
    └── res/
        └── mipmap-*/
            └── ic_launcher.png  (آیکون اصلی برای Production)
```

### نکته: ایجاد آیکون‌ها

می‌توانید از ابزارهای زیر استفاده کنید:
- [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/)
- [App Icon Generator](https://appicon.co/)
- Figma / Adobe XD

## 4. مدیریت Strings و Resources

### فایل: `android/app/src/dev/res/values/strings.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Zero Setup (Dev)</string>
</resources>
```

### فایل: `android/app/src/staging/res/values/strings.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Zero Setup (Staging)</string>
</resources>
```

### فایل: `android/app/src/prod/res/values/strings.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Zero Setup</string>
</resources>
```

## 5. دستورات Build

### Build برای Development

```bash
# Debug
flutter build apk --flavor dev --debug
flutter run --flavor dev

# Release
flutter build apk --flavor dev --release
```

### Build برای Staging

```bash
# Debug
flutter build apk --flavor staging --debug
flutter run --flavor staging

# Release
flutter build apk --flavor staging --release
```

### Build برای Production

```bash
# Debug
flutter build apk --flavor prod --debug
flutter run --flavor prod

# Release
flutter build apk --flavor prod --release
```

## 6. پیکربندی VS Code

### فایل: `.vscode/launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Development",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart",
      "args": [
        "--flavor",
        "dev"
      ]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_staging.dart",
      "args": [
        "--flavor",
        "staging"
      ]
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_prod.dart",
      "args": [
        "--flavor",
        "prod"
      ]
    }
  ]
}
```

## 7. پیکربندی Android Studio

### فایل: `android/.idea/runConfigurations/main_dev.xml`

```xml
<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="main_dev" type="FlutterRunConfigurationType" factoryName="Flutter">
    <option name="filePath" value="$PROJECT_DIR$/lib/main_dev.dart" />
    <option name="additionalArgs" value="--flavor dev" />
    <method v="2" />
  </configuration>
</component>
```

## تست و بررسی

### بررسی Package Names

```bash
# نمایش package name برای هر flavor
adb shell pm list packages | grep zero_setup

# خروجی انتظاری:
# com.example.zero_setup_flutter.dev
# com.example.zero_setup_flutter.staging
# com.example.zero_setup_flutter
```

### نصب همزمان

```bash
# نصب همه flavors به صورت همزمان
flutter build apk --flavor dev --release
flutter install --flavor dev

flutter build apk --flavor staging --release
flutter install --flavor staging

flutter build apk --flavor prod --release
flutter install --flavor prod
```

## مزایا

✅ **نصب همزمان**: چند نسخه از اپ روی یک دستگاه
✅ **تشخیص آسان**: آیکون و نام متفاوت
✅ **مدیریت راحت**: Build و deploy مستقل
✅ **تست راحت‌تر**: تست همزمان چند محیط

## نکات مهم

⚠️ **Signing Config**: برای production حتماً signing config درست تنظیم کنید
⚠️ **ProGuard**: قوانین ProGuard را برای release تست کنید
⚠️ **Version Code**: هر flavor می‌تواند version code مستقل داشته باشد

## خطاهای رایج و راه‌حل

### خطا: Duplicate resources

**راه‌حل**: از `resValue` به جای فایل‌های جداگانه استفاده کنید

### خطا: BuildConfig not generated

**راه‌حل**: در `android/app/build.gradle.kts` اضافه کنید:

```kotlin
android {
    buildFeatures {
        buildConfig = true
    }
}
```

---

**بعدی**: [مرحله 3: سیستم Bootstrap](./03_bootstrap_system.md)
