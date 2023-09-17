import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/env/env_reader.dart';
import 'package:freerasp/freerasp.dart';

final securityConfigProvider = Provider<SecurityConfig>((ref) {
  return SecurityConfig(ref, ref.watch(envReaderProvider));
});

class SecurityConfig {
  final Ref _ref;
  final EnvReader _envReader;

  SecurityConfig(this._ref, this._envReader) {
    _init();
  }

  void _init() async {
// Signing hash of your app
    String base64Hash =
        hashConverter.fromSha256toBase64(_envReader.getHash256());

    // create configuration for freeRASP
    final config = TalsecConfig(
      /// For Android
      androidConfig: AndroidConfig(
        packageName: _envReader.getAndroidBuildID(),
        signingCertHashes: [base64Hash],
        supportedStores: ['some.other.store'],
      ),

      /// For iOS
      iosConfig: IOSConfig(
        bundleIds: [_envReader.getiOSBuildID()],
        teamId: 'M8AK35...',
      ),
      watcherMail: 'your_mail@example.com',
      isProd: true,
    );

    // Setting up callbacks
    final callback = ThreatCallback(
        onAppIntegrity: () => print("App integrity"),
        onObfuscationIssues: () => print("Obfuscation issues"),
        onDebug: () => print("Debugging"),
        onDeviceBinding: () => print("Device binding"),
        onDeviceID: () => print("Device ID"),
        onHooks: () => print("Hooks"),
        onPasscode: () => print("Passcode not set"),
        onPrivilegedAccess: () => print("Privileged access"),
        onSecureHardwareNotAvailable: () =>
            print("Secure hardware not available"),
        onSimulator: () => print("Simulator"),
        onUnofficialStore: () => print("Unofficial store"));

    // Attaching listener
    Talsec.instance.attachListener(callback);

    // start freeRASP
    await Talsec.instance.start(config);
  }
}
