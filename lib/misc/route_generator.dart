import 'package:askinator/screens/leaderboard/leaderboard_view.dart';
import 'package:askinator/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';

// List of the routes of the application, display the corresponding view when called.
class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch ((settings.name ?? '').split('?').firstOrNull) {
      case Routes.splashView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashView(),
        );
      case Routes.leaderboardView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LeaderboardView(),
        );
      default:
        return _errorRoute(settings);
    }
  }

  static Route _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text("N/A"),
          ), // Center
        );
      },
    );
  }
}

class Routes {
  static const String splashView = '/';
  static const String homeView = '/home';
  static const String leaderboardView = '/leaderboard';
}
