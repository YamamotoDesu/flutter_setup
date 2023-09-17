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
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const String androidBuildID = _EnvDev.androidBuildID;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const String iosBuildID = _EnvDev.iosBuildID;
  @EnviedField(varName: 'HASH256')
  static const String hash256 = _EnvDev.hash256;
}

@Envied(path: '.qa.env')
abstract class EnvQA {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvQA.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvQA.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvQA.certificate;
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const String androidBuildID = _EnvQA.androidBuildID;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const String iosBuildID = _EnvQA.iosBuildID;
  @EnviedField(varName: 'HASH256')
  static const String hash256 = _EnvQA.hash256;
}

@Envied(path: '.uat.env')
abstract class EnvUAT {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvUAT.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvUAT.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvUAT.certificate;
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const String androidBuildID = _EnvUAT.androidBuildID;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const String iosBuildID = _EnvUAT.iosBuildID;
  @EnviedField(varName: 'HASH256')
  static const String hash256 = _EnvUAT.hash256;
}

@Envied(path: '.prod.env')
abstract class EnvProd {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvProd.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final int apiKey = _EnvProd.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final String certificate = _EnvProd.certificate;
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static final String androidBuildID = _EnvProd.androidBuildID;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static final String iosBuildID = _EnvProd.iosBuildID;
  @EnviedField(varName: 'HASH256')
  static final String hash256 = _EnvProd.hash256;
}
