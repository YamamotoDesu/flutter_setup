import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/common/error/no_internet_connection_screen.dart';
import 'package:flutter_setup/common/error/no_route_screen.dart';
import 'package:flutter_setup/core/route/notifier/go_router_notifier.dart';
import 'package:flutter_setup/features/auth/presentation/ui/login_screen.dart';
import 'package:flutter_setup/features/auth/presentation/ui/signup_screen.dart';
import 'package:flutter_setup/features/cart/presentation/ui/cart_screen.dart';
import 'package:flutter_setup/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:flutter_setup/features/home/presentation/ui/widget/home_screen.dart';
import 'package:flutter_setup/features/setting/presentation/ui/setting_screen.dart';
import 'package:flutter_setup/core/route/route_name.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _routeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  bool isDuplicate = false;
  final notifier = ref.read(goRouterNotiferProvider);

  return GoRouter(
    navigatorKey: _routeNavigatorKey,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      final isLoggedIn = notifier.isLoggedIn;
      final isGoingToLogin = state.uri.path == '/login';
      final isGoingToNoInternet = state.uri.path == '/noInternet';

      if (isLoggedIn &&
          isGoingToLogin &&
          !isDuplicate &&
          !isGoingToNoInternet) {
        isDuplicate = true;
        return '/'; // redirect to home
      } else if (!isLoggedIn &&
          !isGoingToLogin &&
          !isDuplicate &&
          !isGoingToNoInternet) {
        isDuplicate = true;
        return '/login'; // redirect to login
      }

      if (isDuplicate) {
        isDuplicate = false;
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: _routeNavigatorKey,
        path: '/noInternet',
        name: noInternetRoute,
        builder: (context, state) => NoInternetConnectionScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _routeNavigatorKey,
        path: '/login',
        name: loginRoute,
        builder: (context, state) => LoginScreen(
          key: state.pageKey,
        ),
        routes: [
          GoRoute(
            path: 'signUp',
            name: signUpRoute,
            builder: (context, state) => SignUpScreen(
              key: state.pageKey,
            ),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DashboardScreen(
            key: state.pageKey,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            name: homeRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: HomeScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: '/cart',
            name: cartRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: CartScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
          GoRoute(
            path: '/setting',
            name: settingRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: SettingScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => NoRouteScreen(
      key: state.pageKey,
    ),
  );
});
