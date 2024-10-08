import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_locator.config.dart';

// Setting up dependency injection with [get_it] and [injectable] packages

final sl = GetIt.instance;

@injectableInit
setupDependencyInjection() {
  $initGetIt(sl);
}
