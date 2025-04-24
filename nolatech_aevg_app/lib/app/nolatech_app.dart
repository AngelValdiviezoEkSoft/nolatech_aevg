import 'dart:async';

import 'package:nolatech_aevg_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cron/cron.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

bool mostrarBoton = false;

class NolaTechApp extends StatefulWidget {
  
  const NolaTechApp(Key? key,
  ) : super(key: key);

  @override
  NolaTechAppState createState() => NolaTechAppState();
}

class NolaTechAppState extends State<NolaTechApp> {
  
  final cron = Cron();
  late Stream<ConnectivityResult> connectivityStream;

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _controller.stream;


  @override
  void initState() {
    super.initState();
    mostrarBoton = false;

    connectivityStream = Connectivity().onConnectivityChanged;

    connectivityStream.listen((_) => checkConnection());
    checkConnection();

  }

  @override
  void dispose() {
    cron.close();
    
    _controller.close();
    super.dispose();
  }

  Future<void> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    setState(() {
      mostrarBoton = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp.router(
        title: 'Centro de viajes',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      );
  }
}
