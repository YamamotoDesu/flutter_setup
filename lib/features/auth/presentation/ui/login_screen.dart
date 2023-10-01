import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/base/base_consumer_state.dart';
import 'package:flutter_setup/core/route/notifier/go_router_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ref.read(goRouterNotiferProvider).isLoggeIn = true;
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
