import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../misc/route_generator.dart';

@injectable
class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = sl<NavigationService>();

  void init() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      _navigationService.navigateTo(Routes.homeView);
    });
  }
}
