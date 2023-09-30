import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/common/error/no_internet_connection_screen.dart';
import 'package:flutter_setup/common/error/no_route_screen.dart';
import 'package:flutter_setup/features/cart/presentation/ui/widget/cart_screen.dart';
import 'package:flutter_setup/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:flutter_setup/features/home/presentation/ui/widget/home_screen.dart';
import 'package:flutter_setup/features/setting/presentation/ui/widget/setting_screen.dart';
import 'package:flutter_setup/route/route_name.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/noInternet',
        name: noInternetRoute,
        builder: (context, state) => NoInternetConnectionScreen(
          key: state.pageKey,
        ),
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
