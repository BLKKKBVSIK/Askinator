import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class SplashViewModel extends BaseViewModel {
  void goToHomepage() {}

  void testMethod() {
    sl<AppwriteService>().addScoreToLeaderboard("ENZ", 100, 950);
  }
}
