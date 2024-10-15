import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class GameViewModel extends BaseViewModel {
  List<Message> getMessages() {
    return [
      const TextMessage(
        author: User(id: 'self'),
        id: '1',
        text: 'Is it a man ?',
      ),
      const TextMessage(
        author: User(id: 'askinator'),
        id: '2',
        text: 'Yes !',
      ),
      const TextMessage(
        author: User(id: 'self'),
        id: '3',
        text: 'Is he real ?',
      ),
      const TextMessage(
        author: User(id: 'askinator'),
        id: '4',
        text: 'No',
      ),
    ].reversed.toList();
  }
}
