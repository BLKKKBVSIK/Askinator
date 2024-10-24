class LeaderboardEntry {
  String playerName;
  int score;
  int durationInSeconds;

  LeaderboardEntry({
    required this.playerName,
    required this.score,
    required this.durationInSeconds,
  });

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      playerName: map['PlayerName'].toString(),
      score: map['NumberOfQueryAsked'] as int,
      durationInSeconds: map['GameTimeInSeconds'] as int,
    );
  }
}
