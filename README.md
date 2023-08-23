# [ecom_app](https://github.com/rddewan/flutter-project-setup)

## 1. Github Workflow Srategy
```
git checkout -b qa 
git checkout -b uat 
git checkout -b dev 
git checkout -b main //prod
```
![image](https://github.com/YamamotoDesu/ecom_app/assets/47273077/71318fa2-d889-4baf-99fd-a46d2609d13e)

## 2. Flutter version management
https://fvm.app/
```
brew tap leoafarias/fvm
brew install fvm
fvm install {{version}}
fvm global {{version}}
fvm use {{version}}
```

.vscode/settings.json
```json
{
    "dart.flutterSdkPath": ".fvm/flutter_sdk",
    // Remove .fvm files from search
    "search.exclude": {
        "**/.fvm": true
    },
    // Remove from file watching
    "files.watcherExclude": {
        "**/.fvm": true
    }
}
```

.gitignore
```
.fvm/flutter_sdk
```

## 3. Flutter Flavor Setup

pubspec.yaml
```yaml

dev_dependencies:
  flutter_test:
    sdk: flutter
  # https://pub.dev/packages/flutter_flavorizr
  flutter_flavorizr: ^2.2.1


flavorizr:
  ide: "vscode"
  app:
    android:
      flavorDimensions: "flavor"

  flavors:
    dev:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".development\""
          versionNameSuffix: "\"Dev\""
          signingConfig: signingConfigs.dev
      ios:
        bundleId: "kyo.desu.ecom_app.dev"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    qa:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".qa\""
          versionNameSuffix: "\"QA\""
          signingConfig: signingConfigs.qa
      ios:
        bundleId: "kyo.desu.ecom_app.qa"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    uat:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: "\".uat\""
          versionNameSuffix: "\"UAT\""
          signingConfig: signingConfigs.uat
      ios:
        bundleId: "kyo.desu.ecom_app.uat"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    prod:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          signingConfig: signingConfigs.prod
      ios:
        bundleId: "kyo.desu.ecom_app"
        generateDummyAssets: true
        # icon: ""
        buildSettings:
```

Command
```
flutter pub run flutter_flavorizr
```
