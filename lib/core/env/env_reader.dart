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
