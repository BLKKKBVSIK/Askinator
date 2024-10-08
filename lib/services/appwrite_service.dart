import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:askinator/models/leaderboard_entry.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class AppwriteService with ListenableServiceMixin {
  final bool _isDebugEnabled = true;

  Client? _client;
  Session? _session;

  get isLogIn => _session != null;

  // Id of Appwrite stuff
  final String _projectId = '67052ee7000d48075b33';
  final String _leaderboardDatabase = '67053c830038a5924d56';
  final String _leaderboardCollection = '67053e27001f87a188e4';

  Future<Session?> signInAnonymously() async {
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject(_projectId)
        .setSelfSigned(status: _isDebugEnabled);

    if (_client == null) {
      return null;
    }

    _session = await Account(_client!).getSession(sessionId: 'current');
    _session ??= await Account(_client!).createAnonymousSession();
    return _session;
  }

  Future addScoreToLeaderboard(String playerName, int score, int timeInSeconds) async {
    if (_client == null || isLogIn == false) {
      return null;
    }

    final database = Databases(_client!);

    const Uuid uuid = Uuid();
    final documentId = uuid.v4();

    await database.createDocument(
      databaseId: _leaderboardDatabase,
      collectionId: _leaderboardCollection,
      documentId: documentId,
      data: {
        'PlayerName': playerName,
        'NumberOfQueryAsked': score,
        'GameTimeInSeconds': timeInSeconds,
      },
    );
  }

  Future<List<LeaderboardEntry>> getLeadderboardData() async {
    if (_client == null || isLogIn == false) {
      return [];
    }

    try {
      final database = Databases(_client!);
      final response = await database.listDocuments(
        databaseId: _leaderboardDatabase,
        collectionId: _leaderboardCollection,
        queries: [
          Query.limit(10),
          Query.orderDesc('NumberOfQueryAsked'),
        ],
      );

      List<LeaderboardEntry> leaderboardEntries =
          response.documents.map((e) => LeaderboardEntry.fromMap(e.data)).toList();

      return leaderboardEntries;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return [];
    }
  }
}
