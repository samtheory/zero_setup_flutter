# Step 1: Android Flavors

This step focuses on configuring product flavors in the `android/app/build.gradle.kts` file. This will allow us to build different versions of the app (e.g., dev, stag, prod) from the same codebase.

## 1. Modify `android/app/build.gradle.kts`

Open the `android/app/build.gradle.kts` file and add the following `productFlavors` block inside the `android` block.

```kotlin
android {
    // ... other android configurations

    flavorDimensions += "app" // It is better to use += instead of =

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "Zero Setup (Dev)")
        }
        create("stag") {
            dimension = "app"
            applicationIdSuffix = ".stag"
            resValue("string", "app_name", "Zero Setup (Stag)")
        }
        create("prod") {
            dimension = "app"
            resValue("string", "app_name", "Zero Setup")
        }
    }

    // ... other android configurations
}
```

### Explanation:

*   **`flavorDimensions += "app"`:**  This line declares a flavor dimension named "app". It's a way to group your flavors.
*   **`productFlavors`:** This is where we define our different environments.
*   **`create("dev")`**, **`create("stag")`**, **`create("prod")`:** These create the three flavors.
*   **`dimension = "app"`:** This assigns each flavor to the "app" dimension.
*   **`applicationIdSuffix`:** This will be appended to the `applicationId`. For example, if your base `applicationId` is `com.example.zero_setup_flutter`, the `dev` flavor's `applicationId` will be `com.example.zero_setup_flutter.dev`. This allows you to install all three flavors on the same device.
*   **`resValue("string", "app_name", "...")`:** This creates a string resource named `app_name` for each flavor. This is how we can have a different app name for each environment. You'll need to reference this in your `AndroidManifest.xml`.

## 2. Modify `android/app/src/main/AndroidManifest.xml`

To use the `app_name` resource we just created, you need to modify the `android:label` in your `AndroidManifest.xml`.

```xml
<application
    android:label="@string/app_name"
    ...>
```

Now, when you build a specific flavor, the `android:label` will be replaced with the `app_name` value defined in that flavor's configuration.
