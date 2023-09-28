import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/base/base_consumer_state.dart';
import 'package:flutter_setup/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends BaseConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final index = ref
        .watch(dashboardControllerProvider.select((value) => value.pageIndex));
    return BottomNavigationBar(
      currentIndex: _calulateSelectedIndex(context),
      onTap: (value) => _onItemTapped(value),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        color: Colors.green,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home_filled),
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.shopify),
          icon: Icon(Icons.shopping_bag),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_applications),
          label: "Settings",
        ),
      ],
    );
  }

  static int _calulateSelectedIndex(BuildContext context) {
    final GoRouterState route = GoRouterState.of(context);
    final String location = route.uri.toString();
    if (location == "/") {
      return 0;
    } else if (location == "/cart") {
      return 1;
    } else if (location == "/setting") {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index) {
    //ref.read(dashboardControllerProvider.notifier).setPageIndex(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go("/");
        break;
      case 1:
        GoRouter.of(context).go("/cart");
        break;
      case 2:
        GoRouter.of(context).go("/setting");
        break;
    }
  }
}
