# Step 2: iOS Flavors

This step describes how to set up different environments (flavors) for the iOS version of the app using Xcode Schemes and configurations.

## 1. Open the iOS project in Xcode

```bash
open ios/Runner.xcworkspace
```

## 2. Create New Configurations

In Xcode, go to the "Project" navigator, select the "Runner" project, and then select the "Info" tab. In the "Configurations" section, you will see "Debug" and "Release". We need to create new configurations for our flavors.

1.  Click the `+` button and duplicate the "Debug" configuration. Name it `Debug-dev`.
2.  Duplicate "Debug" again and name it `Debug-stag`.
3.  Duplicate "Debug" again and name it `Debug-prod`.
4.  Duplicate the "Release" configuration and name it `Release-dev`.
5.  Duplicate "Release" again and name it `Release-stag`.
6.  Duplicate "Release" again and name it `Release-prod`.

You should now have a list of configurations like this:

*   Debug
*   Debug-dev
*   Debug-stag
*   Debug-prod
*   Release
*   Release-dev
*   Release-stag
*   Release-prod

## 3. Create New Schemes

Schemes tell Xcode which configuration to use for which action (Run, Test, Profile, Analyze, Archive).

1.  At the top of the Xcode window, next to the "Run" button, click on the current scheme (it's probably called "Runner") and select "New Scheme".
2.  Name the new scheme `dev`.
3.  Repeat the process to create schemes named `stag` and `prod`.

## 4. Edit Schemes to Use the New Configurations

For each new scheme, you need to tell it which build configuration to use.

1.  Click on the scheme selector and choose "Edit Scheme...".
2.  Select the `dev` scheme.
3.  In the left-hand menu, select "Run". In the "Info" tab on the right, set the "Build Configuration" to `Debug-dev`.
4.  Select "Test" and set the "Build Configuration" to `Debug-dev`.
5.  Select "Profile" and set the "Build Configuration" to `Release-dev`.
6.  Select "Analyze" and set the "Build Configuration" to `Debug-dev`.
7.  Select "Archive" and set the "Build Configuration" to `Release-dev`.
8.  Repeat this process for the `stag` and `prod` schemes, selecting the corresponding build configurations (e.g., `Debug-stag` and `Release-stag` for the `stag` scheme).

## 5. Set Bundle ID and App Name

We'll use User-Defined Build Settings to manage the app's bundle ID and display name for each flavor.

1.  In the "Project" navigator, select the "Runner" project, and then select the "Build Settings" tab.
2.  Click the `+` button at the top and select "Add User-Defined Setting".
3.  Name the new setting `APP_BUNDLE_ID_SUFFIX`.
4.  Expand the new setting and set the value for each configuration:
    *   `Debug-dev`: `.dev`
    *   `Debug-stag`: `.stag`
    *   `Debug-prod`: ` ` (leave it empty)
    *   `Release-dev`: `.dev`
    *   `Release-stag`: `.stag`
    *   `Release-prod`: ` ` (leave it empty)
5.  Click the `+` button again and add another User-Defined Setting named `APP_DISPLAY_NAME`.
6.  Expand the new setting and set the value for each configuration:
    *   `Debug-dev`: `Zero Setup (Dev)`
    *   `Debug-stag`: `Zero Setup (Stag)`
    *   `Debug-prod`: `Zero Setup`
    *   `Release-dev`: `Zero Setup (Dev)`
    *   `Release-stag`: `Zero Setup (Stag)`
    *   `Release-prod`: `Zero Setup`

## 6. Update Info.plist

Now, we need to use these User-Defined settings in our `Info.plist` file.

1.  In the "Build Settings" tab, search for "Product Bundle Identifier".
2.  Change the value to `com.example.zeroSetupFlutter$(APP_BUNDLE_ID_SUFFIX)`. Make sure to replace `com.example.zeroSetupFlutter` with your actual bundle identifier.
3.  Search for "Product Name". Change the value to `$(APP_DISPLAY_NAME)`.

Now, when you build and run a specific scheme, it will use the correct bundle ID and app name.
