
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {

  final ScrollController scrollListaClt = ScrollController();

  bool showButtonScrool = false;

  void scrollToTop() {
    scrollListaClt.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return BlocBuilder<GenericBloc, GenericState>(
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
                    if (snapshot.hasData) {

                String objRsp = snapshot.data as String;

                if(objRsp.isNotEmpty){
                  
                  
                } else {
                  listaVaciaPrp = true;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      Container(
                        width: size.width * 0.92,
                        height: size.height * 0.04,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: const Text('Mis favoritos', style: TextStyle(fontSize: 18),),
                      ),

/*
                      if(prospectosFiltrados.isNotEmpty)         
                      SizedBox(height: size.height * 0.02,),

                      if(prospectosFiltrados.isNotEmpty) 
                      */
                      Container(
                        color: Colors.transparent,
                        width: size.width,
                        height: size.height * 0.7,
                        child: Scaffold(
                          body: ListView.builder(
                            controller: scrollListaClt,
                            itemCount: 1,
                            itemBuilder: ( _, int index ) {
                          
                              return Slidable(
                                //key: ValueKey(prospectosFiltrados[index].id),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) 
                                        {
                                          /*
                                          objDatumCrmLead = prospectosFiltrados[index];
                                                    
                                          //ignore: use_build_context_synchronously
                                          FocusScope.of(context).unfocus();
                                                    
                                          terminoBusqueda = '';
                                          filtroPrspTxt = TextEditingController();
                                                    
                                          //context.push(Rutas().rutaPlanificacionActividades);
                                          context.push(Rutas().rutaPlanActivConActiv);
                                          */
                                        },
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.call_outlined,
                                        label: 'Actividades',
                                      ),
                                  
                                    ]
                                ),
                                child: ListTile(
                                  title: Container(
                                  color: Colors.transparent,
                                  width: size.width * 0.98,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: const Color.fromARGB(255, 217, 217, 217)),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                    width: size.width * 0.98,
                                    height: size.height * 0.195,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.7,
                                          height: size.height * 0.25,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: size.width * 0.01,),
                                              Container(
                                                color: Colors.transparent,
                                                width: size.width * 0.14,
                                                height: size.height * 0.1,
                                                child: CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundColor: Colors.grey[200],
                                                  child: const Icon(Icons.person, color: Colors.grey, size: 40.0),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.transparent,
                                                width: size.width * 0.55,
                                                height: size.height * 0.25,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    color: Colors.transparent,
                                                    width: size.width * 0.54,
                                                    height: size.height * 0.04,
                                                    child: Text(
                                                      'Test 1',
                                                      //prospectosFiltrados[index].name,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,                                                                
                                                        color: Colors.black
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.transparent,
                                                    width: size.width * 0.54,
                                                    height: size.height * 0.04,
                                                    child: Text(
                                                      'Test 2',
                                                      //prospectosFiltrados[index].contactName ?? '',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,                                                                
                                                        color: Colors.black
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                color: Colors.transparent,
                                                width: size.width * 0.54,
                                                height: size.height * 0.035,
                                                child: RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Email: ',
                                                        style: TextStyle(color: Colors.black)
                                                      ),
                                                      TextSpan(
                                                        //text: prospectosFiltrados[index].emailFrom,
                                                        style: const TextStyle(color: Colors.blue)
                                                      ),
                                                    ]
                                                  ),
                                                )
                                            
                                              ),
                                              Container(
                                                color: Colors.transparent,
                                                width: size.width * 0.54,
                                                height: size.height * 0.035,
                                                  child: 
                                                  RichText(
                                                    overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                          text: 'Teléfono: ',
                                                          style: TextStyle(color: Colors.black)
                                                        ),
                                                        TextSpan(
                                                          //text: prospectosFiltrados[index].phone,
                                                          style: const TextStyle(color: Colors.blue)
                                                        ),
                                                      ]
                                                    ),
                                                  )
                                              ),
                                              Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.54,
                                                height: size.height * 0.035,
                                                  child: AutoSizeText(
                                                      'Test 3',
                                                      //prospectosFiltrados[index].stageId.name,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.green
                                                        ),
                                                        maxLines: 2,
                                                        textAlign: TextAlign.left,),
                                              ),
                                            
                                                  ],
                                                ),
                                              ),
                                              
                                              
                                            ],
                                          )
                                        ),
                                        Container(
                                          width: size.width * 0.11,
                                          height: size.height * 0.17,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.black12, // Color del óvalo
                                            borderRadius: BorderRadius.circular(50), // Bordes redondeados para el óvalo
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                color: Colors.transparent,
                                                height: size.height * 0.03,
                                                alignment: Alignment.topCenter,
                                                child: IconButton(
                                                  icon: const Icon(Icons.location_pin, color: Colors.grey, size: 20,),
                                                  onPressed: () {
                                                    /*
                                                    final gpsBloc = BlocProvider.of<GpsBloc>(context);
                                                      gpsBloc.askGpsAccess();
                                                      */
                                                    //context.push(Rutas().rutaMap);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                color: Colors.transparent,
                                                height: size.height * 0.03,
                                                alignment: Alignment.topCenter,
                                                child: IconButton(
                                                  icon: const Icon(Icons.route, color: Colors.grey, size: 20,),
                                                  onPressed: () {
                                                    
                                                  },
                                                ),
                                              ),
                                              Container(
                                                color: Colors.transparent,
                                                height: size.height * 0.03,
                                                child: IconButton(
                                                  icon: const Icon(Icons.info, color: Colors.grey, size: 20,),
                                                  onPressed: () {
                                                    /*
                                                    objDatumCrmLead = prospectosFiltrados[index];
                                                    
                                                    //ignore: use_build_context_synchronously
                                                    FocusScope.of(context).unfocus();
                                                    
                                                    terminoBusqueda = '';
                                                    filtroPrspTxt = TextEditingController();
                                                    
                                                    context.push(Rutas().rutaEditProsp);
                                                    */
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.004,)
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.01,)
                                      ],
                                      ),
                                    ),
                                  ),
                                )
                              );
                            },
                          ),
                          floatingActionButton: showButtonScrool
                            ? FloatingActionButton(
                                onPressed: scrollToTop,
                                backgroundColor: Colors.black45,
                                child: const Icon(Icons.arrow_upward, color: Colors.white,),
                              )
                            : null,
                        ),
                      ),
                      
/*
                      if(prospectosFiltrados.isEmpty && !listaVaciaPrp)
                      Container(
                        width: size.width * 0.75,
                        height: size.height * 0.75,
                        color: Colors.transparent,
                        alignment: Alignment.topCenter,
                        child: ConsultaVaciaScreen(null, msmCabBand: 'Atención', msmBand: 'No existe el prospecto buscado', imgCabBand: 'gifs/consulta_vacia.gif',)
                      ),

                      if(prospectosFiltrados.isEmpty && listaVaciaPrp)
                      Container(
                        width: size.width * 0.75,
                        height: size.height * 0.75,
                        color: Colors.transparent,
                        alignment: Alignment.topCenter,
                        child: ConsultaVaciaScreen(null, msmCabBand: 'Atención', msmBand: 'No existe información para mostrar', imgCabBand: 'gifs/consulta_vacia.gif',)
                      )
                      */
                    ],
                  ),
                );
                
              }
                  }

              return Container();
            }
          );
        },
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

}
