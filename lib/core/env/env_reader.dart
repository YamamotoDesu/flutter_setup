import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/env/env.dart';
import 'package:flutter_setup/core/flavor/flavor.dart';
import 'package:flutter_setup/core/flavor/flavor_provider.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  final flvaor = ref.watch(flavorProvider);
  return EnvReader(flvaor);
});

class EnvReader {
  final Flavor _flavor;

  EnvReader(this._flavor);

  String getBaseUrl() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.baseUrl;
      case Flavor.qa:
        return EnvQA.baseUrl;
      case Flavor.uat:
        return EnvUAT.baseUrl;
      case Flavor.prod:
        return EnvProd.baseUrl;
    }
  }

  String getAPIKey() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.apiKey.toString();
      case Flavor.qa:
        return EnvQA.apiKey.toString();
      case Flavor.uat:
        return EnvUAT.apiKey.toString();
      case Flavor.prod:
        return EnvProd.apiKey.toString();
    }
  }

  String getEnvFileName(Flavor flavor) {
    return ".${flavor.name}.env";
  }
}
