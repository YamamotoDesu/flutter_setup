import 'package:flutter/widgets.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

mixin class SetPassCodeScreen {
  void setPassCode(
    BuildContext context, {
    required InputController inputController,
    String correctString = '',
    Widget title = const Text('Create your PassCode'),
    Widget conformTitle = const Text('Confirm your PassCode'),
    bool useLandscape = false,
    int retryDelay = 60,
    required void Function(String) didConfirmed,
    Widget Function(BuildContext, Duration)? delayBuilder,
    Widget? footer,
  }) {
    screenLockCreate(
      context: context,
      inputController: inputController,
      title: title,
      useLandscape: useLandscape,
      confirmTitle: conformTitle,
      digits: 6,
      retryDelay: Duration(seconds: retryDelay),
      maxRetries: 3,
      delayBuilder: delayBuilder ??
          (
            context,
            duration,
          ) =>
              Text(
                'You have to wait ${duration.inSeconds} seconds to try again',
              ),
      onConfirmed: didConfirmed,
      footer: footer,
    );
  }
}
