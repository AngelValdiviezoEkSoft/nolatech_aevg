import 'package:get_it/get_it.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  
  //#Region Blocs 
  getIt.registerLazySingleton(() => VerificacionBloc());
  getIt.registerLazySingleton(() => GenericBloc());
  getIt.registerLazySingleton(() => AuthBloc());
  getIt.registerLazySingleton(() => SuscripcionBloc());
  
  getIt.registerLazySingleton(() => LocationBloc());
  getIt.registerLazySingleton(() => GpsBloc());
  
  /*
  getIt.registerLazySingleton(() => SearchBloc(
    trafficService: TrafficService()
  ));
  */
  //#EndRegion
}
