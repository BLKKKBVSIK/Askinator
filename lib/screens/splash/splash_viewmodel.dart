import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/route_generator.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class SplashViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();
  final NavigationService _navigationService = sl<NavigationService>();

  bool get isLogIn => _appwriteService.isLogIn;

  //TODO(Enzo): Remove this method before build
  Future goToLeaderboard() async {
    await _navigationService.navigateTo(Routes.leaderboardView);
  }
  
  Future testMethod() async {
    // if (!isLogIn) await _appwriteService.signInAnonymously();
    await _appwriteService.getLeadderboardData();
  }

  void navigateToGameView() => _navigationService.navigateTo(Routes.gameView);
}
