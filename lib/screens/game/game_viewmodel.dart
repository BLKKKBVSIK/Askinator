import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/leaderboard/leaderboard_view.dart';
import 'package:askinator/services/appwrite_service.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:askinator/services/shared_preferences_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:injectable/injectable.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

@injectable
class GameViewModel extends BaseViewModel {
  final AppwriteService _appwriteService = sl<AppwriteService>();
  final SharedPreferencesService _sharedPreferenceService = sl<SharedPreferencesService>();
  final NavigationService _navigationService = sl<NavigationService>();

  static const String _successMessage = 'Yes ! You won 🎉';
  static const String lastMessageKey = 'lastMessageKey';

  bool get hasMadeTutorial => _sharedPreferenceService.hasMadeTutorial;

  String lastMessage = ''; // Used to fill the ChatBubble

  bool gameSuccess = false;

  List<Message> messages = [];

  late int _gameSeed;

  // Used to calculate the score
  int _numberOfQuestionsAsked = 0;
  final DateTime _timeWhenGameStart = DateTime.now();
  int score = 9999;

  SMITrigger? _toBat;
  SMITrigger? _reset;

  Future makeCharacterSpeak(List<String> sentences) async {
    for (final sentence in sentences) {
      lastMessage = sentence;
      _addMessage(sentence, isUserMessage: false);
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  Future initGame() async {
    //_sharedPreferenceService.resetHasMadeTutorial();

    if (!hasMadeTutorial) {
      await makeCharacterSpeak([
        'Hello!\nI am Ask-inator',
        'You\'ll be cursed if you don\'t guess the right answer',
        'But don\'t worry, I\'ll help you by answering\nYES or NO',
        'Let\'s start!\n Type your first question',
      ]);
      await _sharedPreferenceService.setHasMadeTutorial(true);
    }

    _gameSeed = 0; //Random().nextInt(4294967296); // 2^32
    messages = [];
    score = 9999;
    gameSuccess = false;
    _reset?.fire();
    notifyListeners();
  }

  void onRiveLoaded(StateMachineController stateMachineController) {
    _toBat = stateMachineController.findInput<bool>('BAT!') as SMITrigger;
    _reset = stateMachineController.findInput<bool>('Reset') as SMITrigger;
  }

  Future _onGameSuccess() async {
    lastMessage = '';
    gameSuccess = true;
    notifyListeners();

    final timeTook = DateTime.now().difference(_timeWhenGameStart).inSeconds;
    score = _numberOfQuestionsAsked * 15 + timeTook;

    _toBat?.fire();
    await makeCharacterSpeak([
      'Your score is $score.',
    ]);
  }

  Future<void> askQuestion(String question) async {
    _numberOfQuestionsAsked++;
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

    await _onGameSuccess();
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
      if (messages.firstOrNull?.id != null) {
        messages[0] = TextMessage(author: const User(id: 'askinator'), id: messages.firstOrNull!.id, text: content);
      }
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

  Future postScore() async {
    await _navigationService.navigateToWithModalAnim(LeaderboardView(
      score: score,
    ));
  }
}
