import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class GameViewModel extends BaseViewModel {
  List<Message> getMessages() {
    return [
      const TextMessage(
        author: User(id: 'self'),
        id: '',
        text: 'Is it a man ?',
      ),
      const TextMessage(
        author: User(id: 'askinator'),
        id: '',
        text: 'Yes !',
      ),
      const TextMessage(
        author: User(id: 'self'),
        id: '',
        text: 'Is he real ?',
      ),
      const TextMessage(
        author: User(id: 'askinator'),
        id: '',
        text: 'No',
      ),
    ].reversed.toList();
  }
}
