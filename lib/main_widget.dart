import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/base/base_consumer_state.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

/// auto generated after you run `flutter pub get`
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_setup/core/providers/app_background_state_provider.dart';
import 'package:flutter_setup/core/providers/internet_connection_observer.dart';

import 'package:flutter_setup/i18n/i18n.dart';
import 'package:flutter_setup/core/route/go_router_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:upgrader/upgrader.dart';

import 'package:flutter_setup/core/auth/local_auth.dart';
import 'package:flutter_setup/core/remote/network_service.dart';

class MainWidget extends ConsumerStatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends BaseConsumerState<MainWidget> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _isNetworkConnected();
    _networkConnectionObserver();
  }

  void _isNetworkConnected() async {
    final isConnected =
        await ref.read(internetConnectionObserverProvider).isNetworkConnected();
    if (!isConnected && mounted) {
      ref.read(goRouterProvider).push('/noInternet');
      // navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (_) => const NoInternetConnectionScreen(),
      //   ),
      // );
    }
  }

  void _networkConnectionObserver() {
    final connectionStream =
        ref.read(internetConnectionObserverProvider).hasConnectionStream.stream;
    connectionStream.listen((isConnected) {
      if (!isConnected && mounted) {
        ref.read(goRouterProvider).push('/noInternet');
        // _showSnackbar();
        // navigatorKey.currentState?.push(
        //   MaterialPageRoute(
        //     builder: (_) => const NoInternetConnectionScreen(),
        //   ),
        // );
      }
    });
  }

  void _showSnackbar() {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text("No internet connection"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override //0:35
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: AppLocales.supportedLocales,
      locale: AppLocales.ja.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        ref.read(appBackgroundStateProvider.notifier).state = true;
      case AppLifecycleState.resumed:
        ref.read(appBackgroundStateProvider.notifier).state = false;
      default:
    }
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  BaseConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseConsumerState<HomePage> {
  int _counter = 0;
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dio = ref.read(networkServiceProvider);
      getSomeData();
    });
  }

  void getSomeData() async {
    final response =
        await _dio.get('https://jsonplaceholder.typicode.com/todos/1');
    // final response = await _dio.get('api/v1/banner/getHomeBannerSlider');
    log.info(response); //20:31
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        upgrader: Upgrader(
          shouldPopScope: () => true,
          canDismissDialog: true,
          durationUntilAlertAgain: const Duration(days: 1),
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translation.buttonPushMsg(_counter),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                onPressed: () async {
                  final didAuthenticate =
                      await ref.read(localAuthProvider).authenticate();
                  if (didAuthenticate) {
                    debugPrint('Authenticated');
                  }
                },
                child: const Text(
                  'Authenticate to unlock',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: translation.increment,
        child: const Icon(Icons.add),
      ), //
    );
  }
}
