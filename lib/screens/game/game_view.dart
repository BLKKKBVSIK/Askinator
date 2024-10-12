import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/askinator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:stacked/stacked.dart';

import '../../misc/color_theme.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => GameViewState();
}

class GameViewState extends State<GameView> with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    value: 0,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameViewModel>.reactive(
        viewModelBuilder: () => sl<GameViewModel>(),
        builder: (context, viewModel, child) {
          return AnimatedMeshGradient(
            colors: [
              ColorTheme.theme.primary,
              ColorTheme.theme.secondaryVariant,
              ColorTheme.theme.secondary,
              ColorTheme.theme.primaryVariant,
            ],
            options: AnimatedMeshGradientOptions(frequency: 2, speed: 2),
            child: Scaffold(
              backgroundColor: ColorTheme.theme.background.withOpacity(0.7),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.arrow_back),
                  color: ColorTheme.theme.onBackground,
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'What is thinking of Askinator this time ?',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorTheme.theme.onBackground),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        const Positioned(
                          top: -50,
                          left: -10,
                          child: Askinator(),
                        ),

                        // Prompt + expanding chat
                        Material(
                          elevation: 2,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                          ),
                          color: ColorTheme.theme.neutral,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_animationController.isAnimating) return;

                                  if (_animation.value == 1) {
                                    _animationController.reverse();
                                    return;
                                  }

                                  _animationController.forward();
                                },
                                icon: const Icon(Icons.arrow_upward),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PhysicalModel(
                                  shadowColor: ColorTheme.theme.primary,
                                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                                  color: Colors.transparent,
                                  elevation: 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(32)),
                                        borderSide: BorderSide(color: ColorTheme.theme.primaryVariant),
                                      ),
                                      hintText: 'Ask a question',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              SizeTransition(
                                sizeFactor: _animation,
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: Chat(
                                    messages: viewModel.getMessages(),
                                    onSendPressed: (_) {},
                                    user: const types.User(id: 'self'),
                                    customBottomWidget: const SizedBox(),
                                    theme: DefaultChatTheme(
                                      backgroundColor: Colors.transparent,
                                      primaryColor: ColorTheme.theme.primary,
                                      secondaryColor: ColorTheme.theme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
