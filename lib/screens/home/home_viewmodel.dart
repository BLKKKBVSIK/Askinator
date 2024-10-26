import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../misc/route_generator.dart';

@injectable
class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = sl<NavigationService>();

  void navigateToGameView() => _navigationService.navigateTo(Routes.gameView);

  void navigateToLeaderboardView() => _navigationService.navigateTo(Routes.leaderboardView);

  void navigateToCreditsView() => _navigationService.navigateTo(Routes.creditsView);
}
