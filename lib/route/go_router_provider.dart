import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/common/error/no_route_screen.dart';
import 'package:flutter_setup/features/setting/presentation/ui/widget/setting_screen.dart';
import 'package:flutter_setup/route/route_name.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/setting',
    routes: <RouteBase>[
      GoRoute(
        path: '/setting',
        name: settingRoute,
        builder: (context, state) => SettingScreen(
          key: state.pageKey,
        ),
      ),
    ],
    errorBuilder: (context, state) => NoRouteScreen(
      key: state.pageKey,
    ),
  );
});
