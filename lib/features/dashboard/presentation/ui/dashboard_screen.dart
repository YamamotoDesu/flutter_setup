import 'package:flutter/material.dart';
import 'package:flutter_setup/features/dashboard/presentation/ui/widget/bottom_navigation_widget.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell child;
  // final Widget child;
  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationWidget(
        child: widget.child,
      ),
    );
  }
}
