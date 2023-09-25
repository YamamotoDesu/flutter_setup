import 'package:flutter/widgets.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

mixin class ShowPassCodeScreen {
  void showPassCode(
    BuildContext context, {
    required String correctString,
    required void Function() didUnlocked,
    Widget title = const Text('Enter your PassCode'),
    bool useLandscape = false,
    int retryDelay = 60,
    Widget Function(BuildContext, Duration)? delayBuilder,
    Widget? footer,
  }) {
    screenLock(
      context: context,
      correctString: correctString,
      title: title,
      useLandscape: useLandscape,
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
      onUnlocked: didUnlocked,
    );
  }
}
