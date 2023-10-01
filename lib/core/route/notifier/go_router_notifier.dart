import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotiferProvider = Provider<GoRouterNotider>((ref) {
  return GoRouterNotider();
});

class GoRouterNotider extends ChangeNotifier {}
