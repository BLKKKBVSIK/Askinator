import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:askinator/models/leaderboard_entry.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../misc/appwrite_ids.dart';

@lazySingleton
class AppwriteService with ListenableServiceMixin {
  static const bool _isDebugEnabled = kReleaseMode;

  Session? _session;

  get isLogIn => _session != null;

  late final Client _client = _isDebugEnabled
      ? Client().setEndpoint('https://cloud.appwrite.io/v1').setProject(projectId)
      : Client()
          .setEndpoint('https://cloud.appwrite.io/v1')
          .setProject(projectId)
          .setSelfSigned(status: _isDebugEnabled);

  late final Functions _functions = Functions(_client);
  late final Databases _databases = Databases(_client);

  Future<Map<String, dynamic>> askQuestion(String question, int seed) async {
    final result = await _functions.createExecution(
      functionId: textGenerationFunction,
      body: jsonEncode({
        "prompt": question,
        "seed": seed,
      }),
      xasync: false,
      method: ExecutionMethod.pOST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (result.responseStatusCode != 200) {
      throw Exception('Unexpected failed response : ${result.responseBody}, ${result.responseStatusCode}');
    }

    return jsonDecode(result.responseBody);
  }

  Future<Session?> signInAnonymously() async {
    // Throws exception quand la session expire (cad ?) (401)
    try {
      _session = await Account(_client).getSession(sessionId: 'current');
    } catch (e) {
      AppwriteException appwriteException = e as AppwriteException;
      if (appwriteException.code == 401) {
        _session = null;
      }
    }
    _session ??= await Account(_client).createAnonymousSession();
    return _session;
  }

  Future addScoreToLeaderboard(String playerName, int score) async {
    if (isLogIn == false) {
      return null;
    }

    const Uuid uuid = Uuid();
    final documentId = uuid.v4();

    await _databases.createDocument(
      databaseId: leaderboardDatabase,
      collectionId: leaderboardCollection,
      documentId: documentId,
      data: {
        'PlayerName': playerName,
        'score': score,
      },
    );
  }

  Future<List<LeaderboardEntry>> getLeadderboardData() async {
    if (isLogIn == false) return [];

    try {
      final database = Databases(_client);
      final response = await database.listDocuments(
        databaseId: leaderboardDatabase,
        collectionId: leaderboardCollection,
        queries: [
          Query.limit(10),
          Query.orderAsc('score'),
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
