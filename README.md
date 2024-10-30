# Summary

- [Askinator](#askinator)
- [Current architecture](#current-architecture)
- [Initialisation/Requirement](#initialisation-requirement)


### Askinator

Askinator, a spooky twist on the classic [Akinator](https://en.akinator.com/) game!  
In this project, the AI has chosen a character, and your goal is to uncover it by asking questions.  
But beware—the AI can only answer 'Yes' or 'No'!

[![Watch the video](https://github.com/user-attachments/assets/f78148e4-aa37-4826-a132-15505a11604d)](https://www.youtube.com/watch?v=pXO6IXGCl1s)

You can see the promo video by clicking [this link](https://www.youtube.com/watch?v=pXO6IXGCl1s).  
You can also play the game with this link on your browser (https://askinator-c6fe5.web.app)

### Current architecture

The project is made using [Flutter](https://flutter.dev/) a Google UI framework created in 2017.
It uses the Google language Dart created in 2011, [Dart](https://dartlang.org/).

The application is based on a MVVM architecture using [Stacked](https://pub.dev/packages/stacked) by FilledStacks as a state management.
The usage of [Stacked](https://pub.dev/packages/stacked) is for maintainability and readability.
 [Stacked](https://pub.dev/packages/stacked) uses implicitly the [Provider](https://pub.dev/packages/provider) package.  
The main idea is to use an MVVM pattern to remove any business logic from the UI layouts by putting this logic in a separated view model. This adds more clarity and maintainability.

We can decompose the project into 3 layers: the Models, The Views, and finally the ViewModels.

<p align="center">
    <img src="https://user-images.githubusercontent.com/20175372/150529665-4007b616-7590-490c-b25b-ef8a30753210.png">
</p>

In the project, the views are for display only.    
They can trigger interactions through Buttons/GestureDetector/Events that will call ViewModel methods.

The ViewModel class can extend different types of abstract ViewModels such as:

- [BaseViewModel](https://github.com/Stacked-Org/stacked/blob/master/README_old.md#baseviewmodel-functionality)
- [ReactiveViewModel](https://github.com/Stacked-Org/stacked/blob/master/README_old.md#reactiveviewmodel)
- And many more, but we mostly use those ones, you can refer to the [stacked documentation](https://pub.dev/documentation/stacked/latest/stacked/stacked-library.html#classes)

The ViewModel data-bind all the data from the services and models and create getters for the view and notify the view of any changes (using a ReactiveServiceMixin or a NotifyListeners)

The project utilizes [AppWrite.io](https://appwrite.io/) as a cloud backend to handle:

- Database Management: Stores information about the leaderboard.
- Anonymous Authentication: Allows players to start the game without requiring sign-in, making it easy and accessible for quick sessions.
- Cloud Functions: Calls a Hugging Face API to enable the AI to respond with a "Yes" or "No" to user questions.
  
This integration allows the app to offer a seamless, interactive experience by handling backend processing efficiently, while Hugging Face provides the natural language processing capability for AI responses.

### Initialisation Requirement

1) Install the Flutter SDK following the [official documentation](https://flutter.dev/docs/get-started/install)
Then use the `flutter doctor` to verify your install
2) Clone the project.
3) Run the `flutter pub get` command to fetch the dependencies needed to build the project.
4) Use the `flutter pub run build_runner build --delete-conflicting-outputs` to generate the [GetIt](https://pub.dev/packages/get_it) config.
4) Finally, use the `flutter run` command to launch your app on your device.

