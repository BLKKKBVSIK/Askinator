import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class GameViewModel extends BaseViewModel {
  List<Message> getMessages() {
    return [
      const TextMessage(
        author: User(id: 'JohnId'),
        id: 'MessageId',
        text: 'myFirstMessage',
      )
    ];
  }
}
