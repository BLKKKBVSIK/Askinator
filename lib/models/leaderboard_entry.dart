class LeaderboardEntry {
  String playerName;
  int score;

  LeaderboardEntry({
    required this.playerName,
    required this.score,
  });

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      playerName: map['PlayerName'].toString(),
      score: map['score'] as int,
    );
  }
}
