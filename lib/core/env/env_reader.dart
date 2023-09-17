import 'dart:convert';
import 'dart:typed_data';

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

  Uint8List getCertificate() {
    switch (_flavor) {
      case Flavor.dev:
        return base64Decode(EnvDev.certificate);
      case Flavor.qa:
        return base64Decode(EnvQA.certificate);
      case Flavor.uat:
        return base64Decode(EnvUAT.certificate);
      case Flavor.prod:
        return base64Decode(EnvProd.certificate);
    }
  }

  String getAndroidBuildID() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.androidBuildID.toString();
      case Flavor.qa:
        return EnvQA.androidBuildID.toString();
      case Flavor.uat:
        return EnvUAT.androidBuildID.toString();
      case Flavor.prod:
        return EnvProd.androidBuildID.toString();
    }
  }

  String getiOSBuildID() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.iosBuildID.toString();
      case Flavor.qa:
        return EnvQA.iosBuildID.toString();
      case Flavor.uat:
        return EnvUAT.iosBuildID.toString();
      case Flavor.prod:
        return EnvProd.iosBuildID.toString();
    }
  }

  String getHash256() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.hash256.toString();
      case Flavor.qa:
        return EnvQA.hash256.toString();
      case Flavor.uat:
        return EnvUAT.hash256.toString();
      case Flavor.prod:
        return EnvProd.hash256.toString();
    }
  }
}
