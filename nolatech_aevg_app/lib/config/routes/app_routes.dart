
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final objRutas = RoutesDesc();

final GoRouter appRouter = GoRouter(
  routes: [//  
    GoRoute(
      path: objRutas.rutaDefault,
      builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return const AuthScreen();
        },
      ),
    ),
    GoRoute(
      path: objRutas.rutaBienvenida,
      builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          
          return FutureBuilder(
            future: state.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if(!snapshot.hasData) {
                return const CargaScreen(null);
              } else {
                if(snapshot.data != '') {
                  
                    if(snapshot.data == 'log') {
                      return const AuthScreen();
                    }
                    if(snapshot.data == 'home') {
                      return const HomeScreen(null);
                    }
                }
              }
              
              return WelcomeScreen(null);
            }
          );
        },
      ),
    ),
    GoRoute(
      path: objRutas.rutaFrmReservation,
      builder: (context, state) => const FrmReservationScreen(),      
    ),
    GoRoute(
      path: objRutas.rutaRegistro,
      builder: (context, state) => const FrmRecordScreen(),      
    ),

    GoRoute(
      path: objRutas.rutaPrincipal,
      builder: (context, state) => const PrincipalScreen(null),      
    ),
    
    /*
    GoRoute(
      path: objRutas.rutaEditarPerfil,
      builder: (context, state) {

        final planAct = BlocProvider.of<GenericBloc>(context);
        planAct.setHeightModalPlanAct(0.11);

        return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthService(),
            lazy: false,
          ),
        ],
        child: const FrmEditPerfilScreen(),
        );        
      },

      //
    ),
    */
   
  ],
  initialLocation: objRutas.rutaBienvenida,
);
//