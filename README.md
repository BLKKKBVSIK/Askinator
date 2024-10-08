# Summary

- [askinator](#askinator)
- [Current architecture](#current-architecture)
- [Initialisation/Requirement](#initialisation-requirement)
- [Troubleshooting](#troubleshooting)


### askinator

The project is made with [Flutter](https://flutter.dev/) a Google UI framework created in 2017.
It uses the Google back-end language Dart created in 2011, [Dart](https://dartlang.org/)

The application is based on a MVVM architecture using [Stacked](https://pub.dev/packages/stacked) by FilledStacks as a state management.
The usage of [Stacked](https://pub.dev/packages/stacked) is for maintainability and readability.
 [Stacked](https://pub.dev/packages/stacked) uses implicitly the [Provider](https://pub.dev/packages/provider) package.


### Current architecture

As previously said, askinator is relying on the [Stacked](https://pub.dev/packages/stacked) package. The main idea is to use an MVVM pattern to remove any business logic from the UI layouts by putting this logic in a separated view model. This adds more clarity and maintainability.

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

### Initialisation Requirement

1) Install the Flutter SDK following the [official documentation](https://flutter.dev/docs/get-started/install)
Then use the `flutter doctor` to verify your install
2) Clone the project.
3) Run the `flutter pub get` command to fetch the dependencies needed to build the project.
4) Use the `flutter pub run build_runner build --delete-conflicting-outputs` to generate the [GetIt](https://pub.dev/packages/get_it) config.
4) Finally, use the `flutter run` command to launch your app on your device.


### Troubleshooting


* (In case of later use of Firebase solution =>) using a M1/M1Pro/M1Max Apple Silicon chip, you may face a [compiling error](https://stackoverflow.com/questions/65089767/class-amsupporturlconnectiondelegate-is-implemented-in-both) about the  Class `AMSupportURLConnectionDelegate` or `AMSupportURLSession` Class being implemented twice:  
    => Be sure you have the good apple profile in your XCode Proj.  
    => Be sure that you are [opening terminal using Rosetta and not with ARM/Native](https://medium.com/codex/simple-way-to-use-cocoapods-on-m1-ac9e22cf7e1c)  
    => Run this command: ```flutter clean && rm ios/Podfile ios/Podfile.lock pubspec.lock && rm -rf ios/Pods ios/Runner.xcworkspace && flutter run```
    
