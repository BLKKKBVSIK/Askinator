import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../misc/appwrite_ids.dart';

@lazySingleton
class AppwriteService with ListenableServiceMixin {
  static const bool _isDebugEnabled = true;

  Session? _session;

  get isLogIn => _session != null;

  late final Client _client =
      Client().setEndpoint('https://cloud.appwrite.io/v1').setProject(projectId).setSelfSigned(status: _isDebugEnabled);

  late final Functions _functions = Functions(_client);
  late final Databases _databases = Databases(_client);

  Future<String> askQuestion(String question) async {
    final result = await _functions.createExecution(
      functionId: textGenerationFunction,
      body: jsonEncode({"prompt": question}),
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

    return jsonDecode(result.responseBody)['answer'];
  }

  Future<Session?> signInAnonymously() async {
    // Throws exception quand la session expire (cad ?) (401)
    _session = await Account(_client).getSession(sessionId: 'current');
    _session ??= await Account(_client).createAnonymousSession();

    return _session;
  }

  Future addScoreToLeaderboard(String playerName, int score, int timeInSeconds) async {
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
        'NumberOfQueryAsked': score,
        'GameTimeInSeconds': timeInSeconds,
      },
    );
  }

  Future getLeadderboardData() async {
    if (isLogIn == false) {
      return null;
    }

    final response = await _databases.listDocuments(
      databaseId: leaderboardDatabase,
      collectionId: leaderboardCollection,
    );

    print(response.documents);

    return response;
  }
}
