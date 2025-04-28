
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/infraestructure/infraestructure.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

int menuMostrar = 0;
int varPosicionMostrar = 0;
List<CanchasModel> lstCanchasGen = [];


class PrincipalScreen extends StatefulWidget {

  const PrincipalScreen(Key? key) : super(key: key);

  @override
  PrincipalStScreen createState() => PrincipalStScreen();
}

class PrincipalStScreen extends State<PrincipalScreen> {

  @override
  void initState() {
    super.initState();

    menuMostrar = 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF67B226),
        elevation: 0,
        title: Row(
          children: [
            Text('Tennis',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            const Text(' court',
                style: TextStyle(
                    color: Color(0xFF2BDE7F), fontWeight: FontWeight.bold)),
            const Spacer(),
            CircleAvatar(backgroundColor: Colors.grey[200], radius: 14),
            const SizedBox(width: 8),
            const Icon(Icons.notifications_none, color: Colors.white),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('¿Está seguro que desea cerrar su sesión?'),
                      
                      actions: [
                        TextButton(
                          onPressed: () async {

                            await AuthService().logOut();

                            //ignore: use_build_context_synchronously
                            context.pop();

                            //ignore: use_build_context_synchronously
                            context.push(objRutasGen.rutaBienvenida);

                          },
                          child: Text('Sí', style: TextStyle(color: Colors.blue[200]),),
                        ),
                        TextButton(
                          onPressed: () {

                            Navigator.of(context).pop();

                            //context.push(objRutasGen.rutaBienvenida);

                          },
                          child: const Text('No', style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    );
                  },
                );

              },
              child: const Icon(Icons.logout, color: Colors.white)),
          ],
        ),
      ),
      body: 
      menuMostrar == 0 ?
      const PrincipalView(null)
      :
      menuMostrar == 1 ?
      const ReservationsView()
      : 
      const FavoritesView(),
      bottomNavigationBar: Container(
          color: Colors.white,
          height: size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: size.width * 0.01,),
              InkWell(
                onTap: () {
                  setState(() {
                    menuMostrar = 0;
                  });
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.17,
                  height: size.height * 0.07,
                  //color: Colors.red,
                  decoration: BoxDecoration(
                    color: menuMostrar == 0 ? ColorsApp().verdeApp : Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,  // Color del borde
                      width: 2,            // Grosor del borde
                    ),
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.17,
                        height: size.height * 0.03,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.home_outlined, color: menuMostrar == 0 ? Colors.white : Colors.black,),
                          color: Colors.white,                  
                          onPressed: () async {                                        
                            setState(() {
                              menuMostrar = 0;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: size.width * 0.17,
                        height: size.height * 0.03,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text('Inicio', style: TextStyle(color: menuMostrar == 0 ? Colors.white : Colors.black),),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    menuMostrar = 1;
                  });
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.17,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    color: menuMostrar == 1 ? ColorsApp().verdeApp : Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,  // Color del borde
                      width: 2,            // Grosor del borde
                    ),
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.17,
                        height: size.height * 0.03,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.calendar_today, color: menuMostrar == 1 ? Colors.white : Colors.black,),
                          color: Colors.white,                  
                          onPressed: () async {
                            setState(() {
                              menuMostrar = 1;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: size.width * 0.17,
                        height: size.height * 0.03,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text('Reservas', style: TextStyle(color: menuMostrar == 1 ? Colors.white : Colors.black),),
                      )
                    
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    menuMostrar = 2;
                  });
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: size.width * 0.17,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    color: menuMostrar == 2 ? ColorsApp().verdeApp : Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,  // Color del borde
                      width: 2,            // Grosor del borde
                    ),
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.17,
                        height: size.height * 0.03,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.favorite_border, color: menuMostrar == 2 ? Colors.white : Colors.black,),
                          color: Colors.white,                  
                          onPressed: () async {
                            setState(() {
                              menuMostrar = 2;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: size.width * 0.17,
                        height: size.height * 0.03,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text('Favoritos', style: TextStyle(color: menuMostrar == 2 ? Colors.white : Colors.black),),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.01,),
            ],
          ),
        ),
    );
  }

  Widget _courtCard(Size size, int index, BuildContext context) {
    return Container(
      width: size.width * 0.55,
      height: size.height * 0.5,
      color: Colors.transparent,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*
            Container(
              width: size.width * 0.9,
              height: size.height * 0.22,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(lstCanchasGen[index].tipoNotificacion,//'assets/images/court_epicbox.png',
                    height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                width: size.width * 0.85,
                height: size.height * 0.18,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      Text(lstCanchasGen[index].idSolicitud,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Spacer(),
                      Icon(Icons.cloud_outlined, size: 16, color: Colors.blue),
                      Text(' 30%', style: TextStyle(fontSize: 12)),
                    ]),
                    SizedBox(height: size.height * 0.005),
                    Row(children: [
                      Text(lstCanchasGen[index].idNotificacionGen,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ]),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        SizedBox(width: size.width * 0.0065),
                        Text(lstCanchasGen[index].mensaje2, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.green),
                        SizedBox(width: 4),
                        Text(lstCanchasGen[index].mensajeNotificacion,
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.5,
                      height: size.height * 0.04,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF67B226),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          minimumSize: Size(double.infinity, 36),
                        ),
                        onPressed: () {
                          context.push(RoutesDesc().rutaFrmReservation);
                        },
                        child: Text(
                          'Reservar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          */
          ],
        ),
      ),
    );
  }

  Widget _reservationCard() {
    return ListTile(
      leading: Image.asset('assets/images/court_epicbox.png',
          width: 60, height: 60, fit: BoxFit.cover),
      title: Text('Epic Box'),
      subtitle:
          Text('6 de julio 2024\nReservado por: Andrea Gómez\n2 horas   \$50'),
      isThreeLine: true,
    );
  }

}

