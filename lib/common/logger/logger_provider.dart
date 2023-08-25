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