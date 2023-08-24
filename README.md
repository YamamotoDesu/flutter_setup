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
        applicationId: "kyo.desu.ecomapp.dev"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: '".development"'
          versionNameSuffix: '"Dev"'
          signingConfig: signingConfigs.dev
      ios:
        bundleId: "kyo.desu.ecomapp.dev"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    qa:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecomapp.qa"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: '".qa"'
          versionNameSuffix: '"QA"'
          signingConfig: signingConfigs.qa
      ios:
        bundleId: "kyo.desu.ecomapp.qa"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    uat:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecomapp.uat"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          applicationIdSuffix: '".uat"'
          versionNameSuffix: '"UAT"'
          signingConfig: signingConfigs.uat
      ios:
        bundleId: "kyo.desu.ecomapp.uat"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

    prod:
      app:
        name: "EcomApp"

      android:
        applicationId: "kyo.desu.ecomapp"
        generateDummyAssets: true
        # icon: ""
        customConfig:
          signingConfig: signingConfigs.prod
      ios:
        bundleId: "kyo.desu.ecomapp"
        generateDummyAssets: true
        # icon: ""
        buildSettings:

```

Command
```
flutter pub run flutter_flavorizr
```

## 4. Configure Environment
lib/core/flavor/flavor.dart
```dart
enum Flavor {
  dev,
  qa,
  uat,
  prod,
}
```

lib/core/env/env_reader.dart
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ecom_app/core/flavor/flavor.dart';

class EnvReader {
  String getEnvFileName(Flavor flavor) {
    return ".${flavor.name}.env";
  }
}
```

lib/main_dev.dart
```dart

Future<void> main() async {
  mainApp(Flavor.dev);
}

```

## 6. Flutter Riverpod Configuration
lib/core/env/env_reader.dart
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flavor/flavor.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  return EnvReader();
});
```

lib/main.dart
```dart
FutureOr<void> mainApp(Flavor flavor) async {
  // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
  final container = ProviderContainer();

  final envReader = container.read(envReaderProvider);
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainWidget(),
    ),
  );
}
```

## 7. Flutter Lint

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    #- dart_code_metrics
  exclude:
    - "**/**.g.dart"
    - "lib/**.g.dart"
    - "**/**.freezed.dart"
    - "lib/**.freezed.dart"
    - "lib/i18n/*"
    - "build/**"
    - "lib/generated/**"

  language:
    #strict-casts: true
    #strict-inference: true
    #strict-raw-types: true

errors:
  todo: ignore
  always_use_package_imports: error
  avoid_print: warning
  annotate_overrides: warning
  avoid_renaming_method_parameters: warning
  avoid_return_types_on_setters: warning
  avoid_returning_null_for_void: error
  avoid_unnecessary_containers: warning
  camel_case_types: error
  flutter_style_todos: warning
  invalid_annotation_target: ignore
  always_declare_return_types: warning
  unused_import: error
  require_trailing_commas: info
  sort_child_properties_last: warning
  no_leading_underscores_for_local_identifiers: info

linter:
  rules:
    always_use_package_imports: true
    avoid_print: true
    annotate_overrides: true
    avoid_renaming_method_parameters: true
    avoid_return_types_on_setters: true
    avoid_returning_null_for_void: true
    avoid_unnecessary_containers: true
    camel_case_types: true
    flutter_style_todos: true
    always_declare_return_types: true
    require_trailing_commas: true
    sort_child_properties_last: true
    library_private_types_in_public_api: false
    no_leading_underscores_for_local_identifiers: false
```

##  8. Logger
pubspec.yaml
```yaml
  # https://pub.dev/packages/logging
  logging: ^1.2.0
```

lib/common/logger/logger_provider.dart
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final loggerProvider = Provider<SetupLogger>((ref) {
  return SetupLogger();
});

class SetupLogger {

  SetupLogger () {
    _init();
  }

  void _init() {
    if (kDebugMode) {

      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {

        if (record.level == Level.SEVERE) {
          debugPrint('${record.level.name}: ${record.time}: ${record.message}: ${record.error}: ${record.stackTrace}');
        } else if (record.level == Level.INFO) {
           debugPrint('${record.level.name}: ${record.message}');
        } else {
          debugPrint('${record.level.name}: ${record.time}: ${record.message}');
        }
      
      });

    } else {
      Logger.root.level = Level.OFF;
    }
  }
}
}
```

lib/base/base_state.dart
```dart
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
 
  Logger get log => Logger(T.toString());
 
  @override
  void initState() {
    log.info('$T initState');
    super.initState();
  }

  void init() {}

  @override
  void dispose() {
    log.info('$T dispose');
    super.dispose();
  }
}
```

lib/base/base_consumer_state.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

abstract class BaseConsumer<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
 
  Logger get log => Logger(T.toString());
 
  @override
  void initState() {
    log.info('$T initState');
    super.initState();
  }

  @override
  void dispose() {
    log.info('$T dispose');
    super.dispose();
  }
}
```

lib/main_widget.dart
```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
```

## 9. keytool
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  # https://pub.dev/packages/flutter_dotenv
  flutter_dotenv: ^5.1.0

flutter:
  uses-material-design: true
  assets:
    - .dev.env
    - .qa.env
    - .uat.env
    - .prod.env
```

.dev.env
```env
BASE_URL=api.dev.yamamoto.desu
API_KEY=1234567
```

lib/core/env/env_reader.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/flavor/flavor.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  return EnvReader();
});

class EnvReader {
  String getEnvFileName(Flavor flavor) {
    return ".${flavor.name}.env";
  }
}
```

lib/main.dart
```dart
FutureOr<void> mainApp(Flavor flavor) async {
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);
```

## 10. Flutter Transiton Sheet
How to set up    
https://github.com/roipeker/flutter_translation_sheet/wiki

pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  flutter_translation_sheet: ^1.0.26
  intl:

flutter:
  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true
  generate: true
```

Enable flutter translation sheet
```
flutter pub global activate flutter_translation_sheet
```

.zshrc
```
Export PATH="$PATH:/$HOME/Development/flutter/.pub-cache/bin"
Export PATH="$PATH:/$HOME/.pub-cache/bin"
```

1. See how to get your Google credentials to connect fts with Google Sheets.
https://github.com/roipeker/flutter_translation_sheet/wiki/Google-credentials

2. Check how to Install fts on your system    
https://github.com/roipeker/flutter_translation_sheet/wiki/Installation

```
fts run
```

trconfig.yaml
```yaml
gsheets:
  credentials_path: credentials.json

  ## Open your google sheet and copy the SHEET_ID from the url:
  ## https://docs.google.com/spreadsheets/d/{SHEET_ID}/edit#gid=0
  spreadsheet_id: 1rU-ovy3_PLFHF_gl.....

  ## The spreadsheet "table" where your translation will live.
  worksheet: シート1
```

```
fts run
```

Delete all files in the l18n folder.


l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_ja.arb
output-localization-file: app_localizations.dart
```

```
fts extract -s -p lib/ -o strings/strings.yaml
```

strings/strings.yaml
```yaml
homeTitle: Flutter Demo Home Page
buttonPushMsg: "You have pushed the button {{counter}} times:"
increment: Increment
home: Home
```

trconfig.yaml
```yaml
output_arb_template: lib/l10n/app_*.arb
entry_file: strings/strings.yaml

  ## Translation Key class and filename reference
  # keys_id: Strings

param_output_pattern: "{*}"

## Writes the locales for Android resources `resConfig()` in app/build.gradle
## And keeps locales_config.xml updated (for Android 33+)
#output_android_locales: true

dart:
  ## Output dir for dart files
  output_dir: lib/i18n

  output_fts_utils: true

  #fts_utils_args_pattern: {}

  ## Translation Key class and filename reference
  # keys_id: Strings

  ## Translations map class an filename reference.
  translations_id: TData

  ## translations as Dart files Maps (practical for hot-reload)
  use_maps: false

dependency_overrides:
  collection: ^1.17.2
  intl: ^0.18.0

```

```
fts run
```

3. Follow the Configuration guide    
https://github.com/roipeker/flutter_translation_sheet/wiki/Configuration-setup

lib/main_widget.dart
```dart
import 'package:flutter_localizations/flutter_localizations.dart';

/// auto generated after you run `flutter pub get`
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_setup/i18n/i18n.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      supportedLocales: AppLocales.supportedLocales,
      locale: AppLocales.ja.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
```

```
flutter clean
fvm flutter pub get
```
