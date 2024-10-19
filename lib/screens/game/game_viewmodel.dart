import 'dart:math';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

@injectable
class GameViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();

  static const String _successMessage = 'Yes ! You won 🎉';
  static const String lastMessageKey = 'lastMessageKey';

  String lastMessage = ''; // Used to fill the ChatBubble
  bool gameSuccess = false;

  List<Message> messages = [];

  late int _gameSeed;

  SMITrigger? _toBat;
  SMITrigger? _reset;

  void initGame() {
    _gameSeed = Random().nextInt(4294967296); // 2^32
    messages = [];
    gameSuccess = false;
    _reset?.fire();
    notifyListeners();
  }

  void onRiveLoaded(StateMachineController stateMachineController) {
    _toBat = stateMachineController.findInput<bool>('BAT!') as SMITrigger;
    _reset = stateMachineController.findInput<bool>('Reset') as SMITrigger;
  }

  void _onGameSuccess() {
    lastMessage = '';
    gameSuccess = true;
    notifyListeners();

    _toBat?.fire();
  }

  Future<void> askQuestion(String question) async {
    question = question.trim();
    if (question.isEmpty) return;
    if (!question.contains('?')) return;

    _addMessage(question, isUserMessage: true);

    _addLoadingMessage();
    notifyListeners();

    String answer = await runBusyFuture(_appwriteService.askQuestion(question, _gameSeed), busyObject: lastMessageKey);

    answer = _sanitizeAnswer(answer);

    lastMessage = answer;
    _addMessage(answer, isUserMessage: false);

    if (answer != _successMessage) return;

    _onGameSuccess();
  }

  void _addMessage(String content, {required bool isUserMessage}) {
    if (isUserMessage) {
      messages.insert(
        0,
        TextMessage(
          author: const User(id: 'player'),
          id: const Uuid().v4(),
          text: content,
        ),
      );
    } else {
      messages[0] = TextMessage(author: const User(id: 'askinator'), id: messages.first.id, text: content);
    }

    notifyListeners();
  }

  void _addLoadingMessage() {
    messages.insert(0, CustomMessage(author: const User(id: 'askinator'), id: const Uuid().v4()));
  }

  String _sanitizeAnswer(String answer) {
    answer = answer.toLowerCase();

    if (answer.contains('yes')) return 'Yes !';
    if (answer.contains('no')) return 'No';
    if (answer.contains('success')) return _successMessage;

    throw Exception('Answer is different');
  }
}
