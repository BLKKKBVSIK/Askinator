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
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return const HomeView();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: 0.0, end: 1.0);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInQuart,
            );

            return FadeTransition(
              opacity: tween.animate(curvedAnimation),
              child: child,
            );
          },
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
  static const String gameView = '/game';
}
