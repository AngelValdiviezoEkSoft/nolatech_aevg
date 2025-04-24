
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nolatech_aevg_app/app/app.dart';
import 'package:nolatech_aevg_app/infraestructure/infraestructure.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:secure_application/secure_application.dart';

void main() async {

  setupServiceLocator();

  await initializeDateFormatting();

  runApp( 
    MultiBlocProvider(
      providers: [//
      
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(AppStarted())),
        BlocProvider(create: (context) => getIt<VerificacionBloc>()),
        BlocProvider(create: (context) => getIt<GenericBloc>()),
        BlocProvider(create: (context) => getIt<SuscripcionBloc>()),
        BlocProvider(create: (context) => getIt<LocationBloc>()),
        BlocProvider(create: (context) => getIt<GpsBloc>()),

      ],
      child: ProviderScope(
        child: SecureApplication(
          secureApplicationController: SecureApplicationController(
            SecureApplicationState(
              secured: true, 
              locked: true
            )
          ),
          child: const NolaTechApp(null)
        )
      ),
    )
  );
}