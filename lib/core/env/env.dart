import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.dev.env')
abstract class EnvDev {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvDev.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvDev.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvDev.certificate;
}

@Envied(path: '.qa.env')
abstract class EnvQA {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvQA.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvQA.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvDev.certificate;
}

@Envied(path: '.uat.env')
abstract class EnvUAT {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvUAT.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvUAT.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvDev.certificate;
}

@Envied(path: '.prod.env')
abstract class EnvProd {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvProd.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvProd.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvDev.certificate;
}
