import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

class PrincipalView extends StatelessWidget {

  const PrincipalView(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Center(
      child: PrincipalViewSt(size: size),
    );
  }
}

class PrincipalViewSt extends StatelessWidget {
  const PrincipalViewSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(        
        onWillPop: () async => false,
      child: BlocBuilder<GenericBloc, GenericState>(
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
      
                String userLog = objRsp[2];
      
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
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text('Hola $userLog!',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 20),
                        const Text('Canchas',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        
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
                        const SizedBox(height: 20),
                        const Text('Reservas programadas',
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
              padding: const EdgeInsets.all(2),
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
                      const Spacer(),
                      const Icon(Icons.cloud_outlined, size: 16, color: Colors.blue),
                      const Text(' 30%', style: TextStyle(fontSize: 12)),
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
                          backgroundColor: const Color(0xFF67B226),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          minimumSize: const Size(double.infinity, 36),
                        ),
                        onPressed: () {
                          context.push(RoutesDesc().rutaFrmReservation);
                        },
                        child: const Text(
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

}
