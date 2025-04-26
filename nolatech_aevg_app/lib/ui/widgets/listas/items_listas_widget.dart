
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/ui/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

String numeroIdentificacionNotificaciones = '';
BuildContext? contextWidget;
int posicionNotificacioRelevante = 0;
Color colorRefreshList = Colors.transparent;
CadenaConexion objCadConNotificaciones = CadenaConexion();
List<String> varLstIdsNots = [];
//UsuarioType? objUserSolicPrincipal;
bool permiteGestionItemsNot = false;
bool muestraListaTramArob = false;
bool muestraListaTramProc = false;
bool muestraListaCompras = false;
bool muestraListaInformativo = false;

//NotificacionEnviroment objNotificacionEnviroment = NotificacionEnviroment();

//ignore: must_be_immutable
class ItemsListasWidget extends StatelessWidget {

  @required String? varIconoNot;
  @required String? varIconoNotTrans;
  @required int? varContadorNotificacion;
  @required int? varIdPosicionMostrar;
  @required final bool? varEsRelevante;
  final int? varIdNotificacion;
  @required String? varNumIdenti;
  final IconData icon;
  @required final String? texto;
  @required final String? texto2;
  @required final String? texto3;
  @required final String? texto4;
  @required final String? texto5;
  final Color color1;
  final Color color2;
  @required final VoidCallback? onPress;

  @required final int? varMuestraNotificacionesTrAp;
  @required final int? varMuestraNotificacionesTrProc;
  @required final int? varMuestraNotificacionesTrComp;
  @required final int? varMuestraNotificacionesTrInfo;
  @required final bool? permiteGestion;
  @required final String? rutaNavegacion;

  ItemsListasWidget(
    Key? key,
    {      
      this.varIconoNot,
      this.varContadorNotificacion,
      this.varIdPosicionMostrar,
      this.varEsRelevante,
      this.varIdNotificacion,
      this.varNumIdenti,
      this.icon = Icons.circle,
      this.texto,
      this.texto2,
      this.texto3,
      this.texto4,
      this.texto5,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      this.onPress,
      this.varMuestraNotificacionesTrAp,
      this.varMuestraNotificacionesTrProc,
      this.varMuestraNotificacionesTrComp,
      this.varMuestraNotificacionesTrInfo,
      //this.objUserSolicVac,
      this.varIconoNotTrans,
      this.permiteGestion,
      this.rutaNavegacion
    }
  ): super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //objUserSolicPrincipal = objUserSolicVac;
    permiteGestionItemsNot = permiteGestion!;

    return Center(
      child: ListaNotificaciones(
        null,
        varIdPosicionMostrarLst: varIdPosicionMostrar,
        varIdNotificacionLst: varIdNotificacion,
        varNumIdentifLst: varNumIdenti,
        color1: color1,
        color2: color2,
        icon: icon,
        onPress2: onPress,
        texto: texto,
        texto2: texto2,
        texto3: texto3,
        texto4: texto4,
        texto5: texto5,
        esRelevante: varEsRelevante,
        varContadorNotificacionLst: varContadorNotificacion,
        varMuestraNotificacionesTrApLst: varMuestraNotificacionesTrAp,
        varMuestraNotificacionesTrProcLst: varMuestraNotificacionesTrProc,
        varMuestraNotificacionesTrCompLst: varMuestraNotificacionesTrComp,
        varMuestraNotificacionesTrInfoLst: varMuestraNotificacionesTrInfo,
        varIconoNot: varIconoNot,
        //objUserSolicVacLst: objUserSolicVac,
        varIconoNotTransLstNot: varIconoNotTrans,
        rutaNavegacionFin: rutaNavegacion,
      ),
      );
  
  }
}

//ignore: must_be_immutable
class ListaNotificaciones extends StatelessWidget {

  @required String? varIconoNot;
  @required String? varIconoNotTransLstNot;
  @required int? varContadorNotificacionLst;
  @required int? varIdPosicionMostrarLst;
  @required final bool? esRelevante;
  final int? varIdNotificacionLst;
  @required String? varNumIdentifLst;
  final IconData icon;
  @required final String? texto;
  @required final String? texto2;
  @required final String? texto3;
  @required final String? texto4;
  @required final String? texto5;
  Color color1;
  final Color color2;
  @required final VoidCallback? onPress2;

  @required final int? varMuestraNotificacionesTrApLst;
  @required final int? varMuestraNotificacionesTrProcLst;
  @required final int? varMuestraNotificacionesTrCompLst;
  @required final int? varMuestraNotificacionesTrInfoLst;
  //@required final UsuarioType? objUserSolicVacLst;
  @required final String? rutaNavegacionFin;


  ListaNotificaciones(
    Key? key,
    {
    this.varIconoNot,
    this.varContadorNotificacionLst,
    this.varIdPosicionMostrarLst,
    this.esRelevante,
    this.varIdNotificacionLst,
    this.varNumIdentifLst,
    this.icon = Icons.circle,
    this.texto,
    this.texto2,
    this.texto3,
    this.texto4,
    this.texto5,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    this.onPress2,
    this.varMuestraNotificacionesTrApLst,
    this.varMuestraNotificacionesTrProcLst,
    this.varMuestraNotificacionesTrCompLst,
    this.varMuestraNotificacionesTrInfoLst,
    this.varIconoNotTransLstNot,
    this.rutaNavegacionFin
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context) {
    contextWidget = context;
    
    numeroIdentificacionNotificaciones = varNumIdentifLst!;
    
    final sizeLstNot = MediaQuery.of(context).size;
    initializeDateFormatting('es'); 
    
    //ItemBoton varObjBoton = ItemBoton('','','',1,icon, '', '','', '', color1, color2,false,false,'','','','','','', () => {},);
    //List<ItemBoton> itemsNot = [];

  if(varIdNotificacionLst == 1) {
    //numNot = 0;
    //numNot = varNumNotificacionesTrAp;
  }

  if(varIdNotificacionLst == 2) {
    //numNot = 0;
    //numNot = varNumNotificacionesTrProc;
  }
  
  if(varIdNotificacionLst == 3) {
    //numNot = 0;
    //numNot = varNumNotificacionesComp;
  }
  
  if(varIdNotificacionLst == 4) {
    //numNot = 0;
    //numNot = varNumNotificacionesInfo;
  }

  return Container(
    color: Colors.transparent,
    width: sizeLstNot.width,
    //height: sizeLstNot.height * 0.2,
    child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context,state) { 
        return GestureDetector(
          onTap: () {            
            context.push(rutaNavegacionFin!);            
          },
          child: Column(
            children: [
              Container(
                width: sizeLstNot.width,
                height: sizeLstNot.height * 0.13,
                margin: const EdgeInsets.all(3), 
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow( color: Colors.black.withOpacity(0.2), offset: const Offset(4,6), blurRadius: 10 ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: <Color>[
                      color1,
                      color2,
                    ]
                  )
                
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  dense: true,
                  minVerticalPadding: 15,
                  title:  Container( 
                    width: sizeLstNot.width * 0.98,//65,
                    height: sizeLstNot.height * 0.11,//90,
                    alignment: Alignment.center, 
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        //SizedBox(width: sizeLstNot.width * 0.025,),

                         GestureDetector(
                          onTap: () {
                            //context.push(rutaNavegacionFin!);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // El círculo de fondo
                              Container(
                                width: sizeLstNot.width * 0.15,  // Tamaño del círculo (ajusta según sea necesario)
                                height: sizeLstNot.height * 0.1,
                                /*
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 224, 232, 235),  // Color de fondo
                                ),
                                */
                                color: Colors.transparent,
                                child: Image.asset('assets/images/court_epicbox.png',
                                  width: 60, height: 40, fit: BoxFit.cover),
                              ),
                              // El icono central (usamos un icono de grupo de personas)
                              /*
                              Icon(
                                icon, // Icono similar al de personas
                                size: 30,  // Tamaño del icono
                                color: Colors.blue[900],  // Color del icono
                              ),
                              */
                            ],
                          ),
                          
                        ),

                        SizedBox(width: sizeLstNot.width * 0.035,),
          
                        //if(texto2 != null && texto2!.isNotEmpty )
                        Container(
                          width: sizeLstNot.width * 0.7,
                          height: sizeLstNot.height * 0.11,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(color: Colors.transparent, width: sizeLstNot.width * 0.55, height: sizeLstNot.height * 0.035,child: AutoSizeText( texto!, style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold ), presetFontSizes: const [18,16,14,12], maxLines: 2,)),
                              
                              Container(
                                color: Colors.transparent, 
                                width: sizeLstNot.width * 0.55, 
                                height: sizeLstNot.height * 0.025,
                                child: Row(
                                  children: [
                                    Container(
                                      width: sizeLstNot.width * 0.05,
                                      height: sizeLstNot.height * 0.05,
                                      color: Colors.transparent,
                                      child: const Icon(Icons.calendar_month, size: 15,)
                                    ),
                                    AutoSizeText( 
                                        texto2!, 
                                        style: const TextStyle( color: Colors.black,   ), 
                                        presetFontSizes: const [14,12,10,8], maxLines: 1,
                                      ),
                                  ],
                                )
                              ),
                              
                              Container(color: Colors.transparent, width: sizeLstNot.width * 0.55, height: sizeLstNot.height * 0.025,child: AutoSizeText( texto3!, style: const TextStyle( color: Colors.black,   ), presetFontSizes: const [14,12,10,8], maxLines: 2,)),

                              Container(
                                color: Colors.transparent, 
                                width: sizeLstNot.width * 0.55, 
                                height: sizeLstNot.height * 0.025,
                                child: Row(
                                  children: [
                                    Container(
                                      width: sizeLstNot.width * 0.05,
                                      height: sizeLstNot.height * 0.05,
                                      color: Colors.transparent,
                                      child: const Icon(Icons.timer_outlined, size: 15,)
                                    ),
                                    AutoSizeText( 
                                        '$texto4 | $texto5',
                                        style: const TextStyle( color: Colors.black,   ), 
                                        presetFontSizes: const [14,12,10,8], maxLines: 1,
                                      ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
          /*
                        if(texto2 == null || texto2!.isEmpty)
                        GestureDetector(
                          onTap: () {    
                            context.push(rutaNavegacionFin!);
                          },
                          child: Container(
                            
                            width: sizeLstNot.width * 0.14,//44,
                            height: sizeLstNot.height * 0.13,//44, 
                            color: Colors.transparent,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {                                  
                                  context.push(rutaNavegacionFin!);
                                },
                                child: Icon(icon, color: Colors.white,))
                            )
                          ),
                        ),
                                   */
                      ],
                    ),                
                  ),
                ),
              ),
                  
            ],
          ),
        );
      }
    )
  ); 

  }
}

class ItemsListasWidgetBackground extends StatelessWidget {
  
    final IconData icon;
    final Color color1;
    final Color color2;
    final String varImgNot;

  const ItemsListasWidgetBackground( Key? key, this.icon, this.color1, this.color2, this.varImgNot ) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.92,//- 35,//double.infinity,
      height: size.height * 0.03,//75,
      margin: const EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow( color: Colors.black.withOpacity(0.2), offset: const Offset(4,6), blurRadius: 10 ),
        ],
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: <Color>[
            color1,
            color2,
          ]
        )
      ), 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 15,
              top: -10,
              child: Image.asset(
                "assets/loadingEnrolApp.gif",
                width: 25,
                height: 25,
              ),
            )
          ],
        ),
      ),

      
    );
  
  }
}
