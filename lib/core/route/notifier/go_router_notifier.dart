import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotiferProvider = Provider<GoRouterNotider>((ref) {
  return GoRouterNotider();
});

class GoRouterNotider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggeIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
