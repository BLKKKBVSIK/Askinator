// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../screens/game/game_viewmodel.dart' as _i4;
import '../screens/home/home_viewmodel.dart' as _i5;
import '../screens/splash/splash_viewmodel.dart' as _i8;
import '../services/appwrite_service.dart' as _i3;
import '../services/navigation_service.dart' as _i6;
import '../services/shared_preferences_service.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AppwriteService>(() => _i3.AppwriteService());
  gh.factory<_i4.GameViewModel>(() => _i4.GameViewModel());
  gh.factory<_i5.HomeViewModel>(() => _i5.HomeViewModel());
  gh.lazySingleton<_i6.NavigationService>(() => _i6.NavigationService());
  gh.lazySingleton<_i7.SharedPreferencesService>(
      () => _i7.SharedPreferencesService());
  gh.lazySingleton<_i8.SplashViewModel>(() => _i8.SplashViewModel());
  return get;
}
