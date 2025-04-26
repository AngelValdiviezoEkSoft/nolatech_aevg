
import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:flutter/material.dart';

String rutaServerWelcome = '';
RoutesDesc objRutasGen = RoutesDesc();
TextEditingController serverTxt = TextEditingController();
TextEditingController keyTxt = TextEditingController();

class WelcomeScreen extends StatelessWidget {

  const WelcomeScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double fem = MediaQuery.of(context).size.width / 417;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/tennis_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: size.width * 0.99,
                  height: size.height * 0.2,
                  padding: const EdgeInsets.fromLTRB(83, 90, 83, 574),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo_tennis_court.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
/*
                Container(
                  //padding: const EdgeInsets.fromLTRB(32, 635, 32, 124),
                  child: ElevatedButton(
                        onPressed: () {
                          // Navegar a login
                          context.push(RoutesDesc().rutaDefault);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Iniciar sesión'),
                      ),
                      
                ),
*/

                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navegar a login
                          context.push(RoutesDesc().rutaDefault);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white),),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          context.push(RoutesDesc().rutaRegistro);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          foregroundColor: Colors.white,
                          minimumSize: Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Registrarme'),
                      ),
                    ],
                  ),
                  
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}