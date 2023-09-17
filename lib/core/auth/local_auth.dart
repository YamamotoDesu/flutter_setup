import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/providers/local_auth_provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

final localAuthProvider = Provider<LocalAuth>((ref) {
  final _localAuthentication = ref.watch(localAuthenticationProvider);
  return LocalAuth(_localAuthentication);
});

class LocalAuth {
  final LocalAuthentication _localAuthentication;

  LocalAuth(this._localAuthentication);

  Future<bool> hasAvailableBiometrics() async {
    final result = await _localAuthentication.getAvailableBiometrics();
    return result.isNotEmpty ? true : false;
  }

  Future<bool> authenticate() async {
    bool didAuthenticate = false;
    try {
      didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to complete the transaction',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case auth_error.notAvailable:
          print('notAvailable');
          break;
        case auth_error.lockedOut:
          print('lockedOut');
          break;
        case auth_error.passcodeNotSet:
          print('passcodeNotSet');
          break;
        case auth_error.notEnrolled:
          print('notEnrolled');
          break;
      }
    } on MissingPluginException {
      print('MissingPluginException');
    } catch (e) {
      print(e);
    }
    return didAuthenticate;
  }
}
