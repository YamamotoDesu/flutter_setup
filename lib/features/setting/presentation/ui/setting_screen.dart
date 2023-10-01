import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_setup/base/base_consumer_state.dart';
import 'package:flutter_setup/common/class/set_pass_code_screen.dart';
import 'package:flutter_setup/common/class/show_pass_code_screen.dart';
import 'package:flutter_setup/core/local/db/hive_constant.dart';
import 'package:flutter_setup/core/route/notifier/go_router_notifier.dart';
import 'package:flutter_setup/features/setting/presentation/conroller/setting_controller.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseConsumerState<SettingScreen>
    with SetPassCodeScreen, ShowPassCodeScreen {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(settingConrollerProvider.notifier)
          .getPassCodeFromBox(passCodeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final passCode =
        ref.watch(settingConrollerProvider.select((value) => value.passCode));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Enable Passcode'),
            subtitle: const Text(
              'enable / disable passcode',
            ),
            trailing: Switch.adaptive(
              value: passCode == null ? false : true,
              onChanged: (value) {
                if (value) {
                  _setPassCode();
                } else {
                  _showPassCode();
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(goRouterNotiferProvider).isLoggeIn = false;
            },
            icon: const Icon(Icons.logout),
            label: const Text('LogOut'),
          )
        ],
      ),
    );
  }

  void _showPassCode() {
    final correctString = ref.read(settingConrollerProvider).passCode ?? '';

    showPassCode(
      context,
      correctString: correctString,
      didUnlocked: () {
        ref
            .read(settingConrollerProvider.notifier)
            .addPassCodeToBox(passCodeKey, null);
        Navigator.of(context).pop();
      },
    );
  }

  void _setPassCode() {
    final inputController = InputController();

    setPassCode(
      context,
      inputController: inputController,
      didConfirmed: (matchedText) {
        ref
            .read(settingConrollerProvider.notifier)
            .addPassCodeToBox(passCodeKey, matchedText);
        Navigator.of(context).pop();
      },
      footer: TextButton(
        onPressed: () {
          inputController.unsetConfirmed();
        },
        child: const Text(
          'Clear and Return to enter mode',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
