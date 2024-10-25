import 'package:askinator/screens/credits/credits_view.dart';
import 'package:askinator/screens/leaderboard/leaderboard_view.dart';
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
      case Routes.leaderboardView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LeaderboardView(),
        );
      case Routes.gameView:
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1500),
            reverseTransitionDuration: const Duration(milliseconds: 1500),
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return const GameView();
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              if (animation.value <= 0.5) {
                final curvedAnimation = CurvedAnimation(parent: animation, curve: const Interval(0, 0.5));

                return FadeTransition(
                  opacity: curvedAnimation,
                  child: const ColoredBox(color: Colors.black, child: SizedBox.expand()),
                );
              }

              final curvedAnimation = CurvedAnimation(parent: animation, curve: const Interval(0.5, 1));

              return Stack(
                children: [
                  const ColoredBox(color: Colors.black, child: SizedBox.expand()),
                  FadeTransition(
                    opacity: curvedAnimation,
                    child: child,
                  ),
                ],
              );
            });
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
      case Routes.creditsView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CreditsView(),
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
  static const String gameView = '/game';
  static const String creditsView = '/credits';
}
