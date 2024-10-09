import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class SplashViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();

  bool get isLogIn => _appwriteService.isLogIn;

  Future testMethod() async {
    // if (!isLogIn) await _appwriteService.signInAnonymously();
    await _appwriteService.getLeadderboardData();
  }
}
