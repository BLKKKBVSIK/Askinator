import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class SharedPreferencesService with ListenableServiceMixin {
  late SharedPreferences _prefs;

  Future init() async {
    debugPrint("[Shared Preference] Service initialized.");
    await SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  bool get hasMadeTutorial => _prefs.getBool('hasMadeTutorial') ?? false;

  Future setHasMadeTutorial(bool value) async {
    await _prefs.setBool('hasMadeTutorial', value);
  }

  void resetHasMadeTutorial() {
    _prefs.remove('hasMadeTutorial');
  }
}
