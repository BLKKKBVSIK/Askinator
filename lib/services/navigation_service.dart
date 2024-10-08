import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

// Define a service that will be used to manage the navigation of the app
@lazySingleton
class NavigationService with ListenableServiceMixin {
  NavigationService() {
    listenToReactiveValues([]);
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Navigate to route
  Future navigateTo(String routeName) {
    debugPrint('Navigating to $routeName');
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  // Navigate to with animation
  Future navigateToWithModalAnim(
    Widget pushedView,
  ) async {
    final res = await navigatorKey.currentState!.push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pushedView,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
    return res;
  }

  // Navigate to route and remove all previous routes
  Future navigateToAndReplace(String routeName) {
    debugPrint('Navigating to $routeName - Replacing previous view.');
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future navigateToAndReplaceWithArgs(String routeName, Object arguments) {
    debugPrint('Navigating to $routeName with arguments $arguments - Replacing previous view.');
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Navigate with arguments
  Future navigateToWithArgs(String routeName, Object arguments) {
    debugPrint('Navigating to $routeName with arguments $arguments');
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // Navigate with arguments
  Future navigateToWithArgsAndReplace(
    String routeName,
    Object arguments,
  ) {
    debugPrint('Navigating to $routeName with arguments $arguments');
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Pop screens until home screen
  /*  void popUntilHome() {
    debugPrint('Popping until home screen');
    navigatorKey.currentState!.popUntil((route) => route.settings.name == Routes.homepageView);
  } */

  // pop until with args
  popUntilWithArgs(String routeName, Object arguments) {
    navigatorKey.currentState!.popUntil((route) {
      if (route.settings.name == routeName) {
        return true;
      }
      return false;
    });
    navigateToAndReplaceWithArgs(routeName, arguments);
  }

  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil((route) {
      if (route.settings.name == routeName) {
        return true;
      }
      return false;
    });
  }

  // Show a snackbar
  void showSnackbar(String message, {Color backgroundColor = Colors.green}) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content:
          Text(message, style: Theme.of(navigatorKey.currentState!.context).textTheme.bodyMedium),
      duration: const Duration(seconds: 3),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      closeIconColor: Theme.of(navigatorKey.currentState!.context).textTheme.bodyMedium?.color,
      margin: const EdgeInsets.all(10),
      dismissDirection: DismissDirection.horizontal,
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        1,
      ),
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }

  // Go to previous route
  void goBack() {
    return navigatorKey.currentState!.canPop() ? navigatorKey.currentState!.pop() : null;
  }

  // Go to previous route with arguments
  void goBackWithArgs(Object arguments) {
    return navigatorKey.currentState!.pop(arguments);
  }
}
