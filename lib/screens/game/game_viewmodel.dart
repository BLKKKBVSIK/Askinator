import 'package:askinator/di/service_locator.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

@injectable
class GameViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();

  final List<Message> messages = [];

  Future<void> askQuestion(String question) async {
    _addMessage(question, isUserMessage: true);
    final answer = await _appwriteService.askQuestion(question);

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
}
