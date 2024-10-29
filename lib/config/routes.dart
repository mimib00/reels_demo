import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reels_demo/features/reels/presentation/views/home.dart';

class Routes {
  static const String home = '/';

  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static GoRouter router = GoRouter(
    navigatorKey: _navigatorKey,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
