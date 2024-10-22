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

  void init() async {
    final data = await rootBundle.load('assets/bat.riv');
     batFile = RiveFile.import(data);
  }

  void navigateToHomeView() {
    _navigationService.navigateTo(Routes.homeView);
  }
}
