import 'package:askinator/di/service_locator.dart';
import 'package:askinator/models/leaderboard_entry.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class LeaderboardViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();

  List<LeaderboardEntry> leaderboardEntries = [];

  Future initialise() async {
    // leaderboardEntries = await _appwriteService.getLeadderboardData();
    leaderboardEntries = [
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
      LeaderboardEntry(playerName: 'Enzo', score: 500, durationInSeconds: 120),
    ];
    notifyListeners();
  }
}
