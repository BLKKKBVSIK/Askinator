import 'package:askinator/screens/game/game_view.dart';
import 'package:askinator/screens/home/home_view.dart';
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
      case Routes.gameView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const GameView(),
        );
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());

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
  static const String gameView = '/game';
}
