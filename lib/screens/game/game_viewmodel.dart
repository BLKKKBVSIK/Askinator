import 'dart:math';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

@injectable
class GameViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();

  static const String lastMessageKey = 'lastMessageKey';
  String lastMessage = ''; // Used to fill the ChatBubble

  final List<Message> messages = [];

  late int _gameSeed;

  void initGame() {
    _gameSeed = Random().nextInt(4294967296); // 2^32
  }

  Future<void> askQuestion(String question) async {
    question = question.trim();
    if (question.isEmpty) return;
    if (!question.contains('?')) return;

    _addMessage(question, isUserMessage: true);

    String answer = await runBusyFuture(_appwriteService.askQuestion(question, _gameSeed), busyObject: lastMessageKey);
    answer = _sanitizeAnswer(answer);

    lastMessage = answer;
    _addMessage(answer, isUserMessage: false);
  }

  void _addMessage(String content, {required bool isUserMessage}) {
    messages.insert(
      0,
      TextMessage(
        author: isUserMessage ? const User(id: 'player') : const User(id: 'askinator'),
        id: const Uuid().v4(),
        text: content,
      ),
    );

    notifyListeners();
  }

  String _sanitizeAnswer(String answer) {
    answer = answer.toLowerCase();

    if (answer.contains('yes')) return 'Yes !';
    if (answer.contains('no')) return 'No';

    throw Exception('Answer is different');
  }
}
