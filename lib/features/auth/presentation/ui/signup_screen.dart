import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/base/base_consumer_state.dart';
import 'package:flutter_setup/core/route/notifier/go_router_notifier.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("SignUp Screen"),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(goRouterNotiferProvider).isLoggeIn = false;
            },
            icon: const Icon(Icons.login),
            label: const Text('SignUp'),
          ),
        ],
      ),
    );
  }
}
