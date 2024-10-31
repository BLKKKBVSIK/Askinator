import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

import '../../misc/route_generator.dart';

@LazySingleton()
class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = sl<NavigationService>();

  late final RiveFile batFile;
  late final AudioPlayer audioPlayer;

  late final List<Future> _initFutures = [];

  void init(BuildContext context) {
    audioPlayer = AudioPlayer()..setLoopMode(LoopMode.all);

    _initFutures.addAll([
      rootBundle.load('assets/anims/bat.riv').then((data) {
        batFile = RiveFile.import(data);
      }),
      audioPlayer.setUrl('asset:/assets/sounds/theme.mp3'),
      precacheImage(const AssetImage('assets/images/home-background.jpg'), context),
      precacheImage(const AssetImage('assets/images/background.jpg'), context),
    ]);
  }

  bool isPlayingMusic = false;

  void playMusic() {
    audioPlayer.play();
    isPlayingMusic = true;
    notifyListeners();
  }

  void toggleMusic() {
    if (!isPlayingMusic) return playMusic();

    audioPlayer.pause();
    isPlayingMusic = false;
    notifyListeners();
  }

  void onAnimationCompleted(VoidCallback hideLoading) async {
    // prevent going on next screen while the assets files aren't loaded
    await Future.wait(_initFutures);

    hideLoading();
    _navigationService.navigateTo(Routes.homeView);
  }
}
