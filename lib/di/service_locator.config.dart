// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../screens/leaderboard/leaderboard_viewmodel.dart' as _i4;
import '../screens/splash/splash_viewmodel.dart' as _i6;
import '../services/appwrite_service.dart' as _i3;
import '../services/navigation_service.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.LeaderboardViewModel>(() => _i4.LeaderboardViewModel());
  gh.lazySingleton<_i5.NavigationService>(() => _i5.NavigationService());
  gh.factory<_i6.SplashViewModel>(() => _i6.SplashViewModel());
  return get;
}
