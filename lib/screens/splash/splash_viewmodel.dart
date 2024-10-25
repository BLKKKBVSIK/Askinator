import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

import '../../misc/route_generator.dart';

@LazySingleton()
class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = sl<NavigationService>();

  late final RiveFile batFile;
  late final Future<void> _batLoadingFuture;

  void init() {
    _batLoadingFuture = rootBundle.load('assets/bat.riv').then((data) {
      batFile = RiveFile.import(data);
    });
  }

  void onAnimationCompleted(VoidCallback hideLoading) async {
    // prevent going on next screen while the bat rive file isn't loaded
    await _batLoadingFuture;

    hideLoading();
    _navigationService.navigateTo(Routes.homeView);
  }
}
