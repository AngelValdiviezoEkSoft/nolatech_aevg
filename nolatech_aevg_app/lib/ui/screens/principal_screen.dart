import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

int varPosicionMostrar = 0;
List<ItemBoton> lstCanchasGen = [];

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF67B226),
        elevation: 0,
        title: Row(
          children: [
            Text('Tennis',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(' court',
                style: TextStyle(
                    color: Color(0xFF2BDE7F), fontWeight: FontWeight.bold)),
            Spacer(),
            CircleAvatar(backgroundColor: Colors.grey[200], radius: 14),
            SizedBox(width: 8),
            Icon(Icons.notifications_none, color: Colors.white),
          ],
        ),
      ),
      body: BlocBuilder<GenericBloc, GenericState>(
        builder: (context,state) {
          return FutureBuilder(
            future: state.readPrincipalPage(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

              if(!snapshot.hasData) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Image.asset(
                      "assets/gifs/gif_carga.gif",
                      height: size.width * 0.85,
                      width: size.width * 0.85,
                    ),
                  ),
                );
              }
                  else {
                    if(snapshot.data != null && snapshot.data!.isNotEmpty) {
                      
              String rspTmp = snapshot.data as String;

              var objRsp = rspTmp.split('---');

              List<ItemBoton> lstMenu = state.deserializeItemBotonMenuList(objRsp[0]);
              lstCanchasGen = state.deserializeItemBotonMenuList(objRsp[1]);

              List<Widget> itemMap = lstMenu
              .map((item) => FadeInLeft(
                    duration: const Duration(milliseconds: 250),
                    child: ItemsListasWidget(
                      null,
                      varIdPosicionMostrar: varPosicionMostrar,
                      varEsRelevante: item.esRelevante,
                      varIdNotificacion: item.ordenNot,
                      varNumIdenti: numeroIdentificacion,
                      icon: item.icon,
                      texto: item.mensajeNotificacion,
                      texto2: item.mensaje2,
                      texto3: item.fechaNotificacion,
                      texto4: item.tiempoDesde,
                      texto5: item.estadoLeido,
                      color1: item.color1,
                      color2: item.color2,
                      onPress: () {},
                      varMuestraNotificacionesTrAp: 0,
                      varMuestraNotificacionesTrProc: 0,
                      varMuestraNotificacionesTrComp: 0,
                      varMuestraNotificacionesTrInfo: 0,
                      varIconoNot: item.iconoNotificacion,
                      varIconoNotTrans: item.rutaImagen,
                      permiteGestion: permiteGestion,
                      rutaNavegacion: item.rutaNavegacion,
                    ),
                  ))
              .toList();

                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Text('Hola Andrea!',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      SizedBox(height: 20),
                      Text('Canchas',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      
                      Container(
                        width: size.width * 0.9,
                        height: size.height * 0.42,
                        color: Colors.transparent,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return _courtCard(size, index, context);                            
                          },
                          itemCount: lstCanchasGen.length,
                          autoplayDisableOnInteraction: true,
                          autoplay: true,                          
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Reservas programadas',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(height: size.height * 0.0007),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: size.width * 0.99,
                        height: size.height * 0.35,
                        color: Colors.transparent,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: <Widget>[
                            const SizedBox(
                              height: 3,
                            ),
                            ...itemMap,
                          ],
                        ),
                      ),
                      //_reservationCard(),
                    ],
                  );
                
                    }
                  }

              return Container();
            }
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF67B226),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Reservas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favoritos'),
        ],
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
