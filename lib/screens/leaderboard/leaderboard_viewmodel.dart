import 'package:askinator/di/service_locator.dart';
import 'package:askinator/models/leaderboard_entry.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class LeaderboardViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();

  List<LeaderboardEntry> leaderboardEntries = [];

  bool hasSendScore = false;

  // Used for writing player name
  TextEditingController firstCharacterController = TextEditingController();
  TextEditingController secondCharacterController = TextEditingController();
  TextEditingController thirdCharacterController = TextEditingController();

  Future initialise() async {
    leaderboardEntries = await _appwriteService.getLeadderboardData();
    notifyListeners();
  }

  void sendScore(int score) async {
    final name = firstCharacterController.text + secondCharacterController.text + thirdCharacterController.text;

    print(name);

    await _appwriteService.addScoreToLeaderboard(name, score);
    hasSendScore = true;
    initialise();
    notifyListeners();
  }
}
