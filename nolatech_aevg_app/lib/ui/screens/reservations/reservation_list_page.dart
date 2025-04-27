
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;

//List<DatumCrmLead> prospectosFiltrados = [];
String terminoBusqueda = '';
//DatumCrmLead? objDatumCrmLead;
late TextEditingController filtroPrspTxt;
bool listaVaciaPrp = false;
bool actualizaListaPrp= false;

class ReservationListScreen extends StatefulWidget {
  const ReservationListScreen({super.key});

  @override
  State<ReservationListScreen> createState() => _ReservationListScreenState();
}

//class MarcacionScreen extends StatelessWidget {
class _ReservationListScreenState extends State<ReservationListScreen> {

  bool showButtonScrool = false;
  final ScrollController scrollListaClt = ScrollController();

  late int _pageSize;
  int contLst = 0;
  final LocalAuthentication auth = LocalAuthentication();
  //final PagingController<int, DatumCrmLead> pagingController = PagingController(firstPageKey: 0);

  void scrollToTop() {
    scrollListaClt.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    actualizaListaPrp = false;
    contLst = 0;
    terminoBusqueda = '';
    filtroPrspTxt = TextEditingController();
    /*
    prospectosFiltrados = [];
    pagingController.addPageRequestListener((pageKey) {
      //fetchPage(pageKey);
    });
    */

    scrollListaClt.addListener(() {
      if (scrollListaClt.offset > 200 && !showButtonScrool) {
        setState(() {
          showButtonScrool = true;
        });
      } else if (scrollListaClt.offset <= 200 && showButtonScrool) {
        setState(() {
          showButtonScrool = false;
        });
      }
    });
  }

  @override
  void dispose() {
    //pagingController.dispose();
    super.dispose();
  }
/*
  Future<void> fetchPage(int pageKey) async {
     try {
      final url = Uri.parse(
          "https://api.ejemplo.com/leads?page=$pageKey&size=$_pageSize"); // API ficticia
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newItems = (data['items'] as List)
            .map((item) => DatumCrmLead.fromJson(item))
            .toList();

        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        throw Exception('Error al cargar datos paginados');
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshDataProsp() async {

    String resInt = await ValidacionesUtils().validaInternet();

    showDialog(
      //ignore:use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        children: [
          SimpleDialogCargando(
            null,
            mensajeMostrar: 'Estamos consultando',
            mensajeMostrarDialogCargando: 'el listado de prospectos.',
          ),
        ]
      ),
    );

    if(resInt.isEmpty){
      var rspPrsp = await ProspectoTypeService().getProspectos();

      var objLogDecode = json.decode(rspPrsp);
      var objLogDecode2 = json.decode(objLogDecode);

      var tstLength = objLogDecode2["result"]["data"]["crm.lead"]["length"];

      String contStr = '$tstLength';

      contLst = 0;

      contLst = int.parse(contStr);

      CrmLeadAppModel apiResponse = CrmLeadAppModel.fromJson(objLogDecode2["result"]["data"]["crm.lead"]);

      List<CrmLeadDatumAppModel> prospectosFiltrados = [];

      if(terminoBusqueda.isNotEmpty){
        
        if(!terminoBusqueda.contains('+') && !terminoBusqueda.contains('0')){

          for(int i = 0; i < apiResponse.data.length; i++){
            if(apiResponse.data[i].name != null && apiResponse.data[i].name!.toLowerCase().contains(terminoBusqueda.toLowerCase())){
              prospectosFiltrados.add(apiResponse.data[i]);
            }
          }

          if(prospectosFiltrados.isEmpty){

            for(int i = 0; i < apiResponse.data.length; i++){
              if(apiResponse.data[i].contactName != null && apiResponse.data[i].contactName!.toLowerCase().contains(terminoBusqueda.toLowerCase())){
                prospectosFiltrados.add(apiResponse.data[i]);
              }
            }

          }

          if(prospectosFiltrados.isEmpty){

            for(int i = 0; i < apiResponse.data.length; i++){
              if(apiResponse.data[i].emailFrom != null && apiResponse.data[i].emailFrom!.toLowerCase().contains(terminoBusqueda.toLowerCase())){
                prospectosFiltrados.add(apiResponse.data[i]);
              }
            }
          }
        } else {
          if(prospectosFiltrados.isEmpty && (terminoBusqueda.contains('+') || terminoBusqueda.contains('0'))){
            for(int i = 0; i < apiResponse.data.length; i++){
              if(apiResponse.data[i].phone != null && apiResponse.data[i].phone!.contains(terminoBusqueda)){
                prospectosFiltrados.add(apiResponse.data[i]);
              }
            }
          }
        }

        contLst = prospectosFiltrados.length;
      } else{
        prospectosFiltrados = apiResponse.data;
      }

      //ignore:use_build_context_synchronously
      context.pop();

      // Refresca los datos llamando a la misma función de carga
      setState(() {
        
      });
    } else {

      //ignore:use_build_context_synchronously
      context.pop();

      showDialog(
        barrierDismissible: false,
        //ignore:use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return ContentAlertDialog(
            onPressed: () {
              Navigator.of(context).pop();
            },
            onPressedCont: () {
              Navigator.of(context).pop();
            },
            tipoAlerta: TipoAlerta().alertAccion,
            numLineasTitulo: 1,
            numLineasMensaje: 1,
            titulo: 'Error',
            mensajeAlerta: 'No tiene acceso a internet.'
          );
        },
      );
    }

  }
*/
  @override
  Widget build(BuildContext context) {

    ColorsApp objColorsApp = ColorsApp();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              //ignore: use_build_context_synchronously
              FocusScope.of(context).unfocus();

              terminoBusqueda = '';
              filtroPrspTxt = TextEditingController();
              context.pop();
            },
          ),
          //title: const Text('Prospectos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {
                //refreshDataProsp();
              },
            ),
            IconButton(
              icon: const Icon(Icons.drag_handle_rounded, color: Colors.black),
              onPressed: () {
                
              },
            ),
          ],
        ),
      body: BlocBuilder<GenericBloc, GenericState>(
        builder: (context,state) {

          Future<void> refreshDataByFiltro(String filtro, String objMemoria) async {            
            /*
            prospectosFiltrados = [];

            CrmLead apiResponse = CrmLead.fromJson(objMemoria);

            if(terminoBusqueda.isNotEmpty){
              
              if(!terminoBusqueda.contains('+') && !terminoBusqueda.contains('0')){
                
                for(int i = 0; i < apiResponse.data.length; i++){
                  if(apiResponse.data[i].emailFrom.toLowerCase().contains(terminoBusqueda.toLowerCase()) 
                  || apiResponse.data[i].name.toLowerCase().contains(terminoBusqueda.toLowerCase()) 
                  || (apiResponse.data[i].contactName != null && apiResponse.data[i].contactName!.toLowerCase().contains(terminoBusqueda.toLowerCase()))){
                    prospectosFiltrados.add(apiResponse.data[i]);
                  }
                }

/*
                if(prospectosFiltrados.isEmpty){
                  prospectosFiltrados = apiResponse.data
                  .where(
                    (producto) => 
                      producto.name.toLowerCase().contains(terminoBusqueda.toLowerCase()))
                  .toList();
                }

                if(prospectosFiltrados.isEmpty){
                  for(int i = 0; i < apiResponse.data.length; i++){
                    if(apiResponse.data[i].contactName != null && apiResponse.data[i].contactName!.toLowerCase().contains(terminoBusqueda.toLowerCase())){
                      prospectosFiltrados.add(apiResponse.data[i]);
                    }
                  }
                }

                if(prospectosFiltrados.isEmpty){
                  prospectosFiltrados = apiResponse.data
                  .where((producto) =>
                    producto.emailFrom.toLowerCase().contains(terminoBusqueda.toLowerCase())
                  ).toList();
                }
                */
              } else {
                if(prospectosFiltrados.isEmpty && (terminoBusqueda.contains('+') || terminoBusqueda.contains('0'))){
                  for(int i = 0; i < apiResponse.data.length; i++){
                    if(apiResponse.data[i].phone != null && apiResponse.data[i].phone!.contains(terminoBusqueda)){
                      prospectosFiltrados.add(apiResponse.data[i]);
                    }
                  }
                }
              }

              contLst = 0;

              contLst = prospectosFiltrados.length;
            } else{
              prospectosFiltrados = apiResponse.data;
            }            

            if(terminoBusqueda.isNotEmpty && actualizaListaPrp) {
              //setState(() {});
            }
            */

          }


          return FutureBuilder(
            future: state.lstProspectos(),
            builder: (context, snapshot) {

              if (snapshot.hasError) {
                return const Center(
                  child: AutoSizeText(
                    '!UPS¡, intenta acceder después de unos minutos.',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }

              if (snapshot.hasData) {

                String objRsp = snapshot.data as String;                

                if(objRsp.isNotEmpty){
                  var objLogDecode = json.decode(objRsp);

                  var tstLength = objLogDecode["length"];

                  String contStr = '$tstLength';

                  contLst = 0;

                  contLst = int.parse(contStr);

                  refreshDataByFiltro('', objRsp);
                  
                  listaVaciaPrp = false;
                  
                } else {
                  listaVaciaPrp = true;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
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
                            itemCount: contLst,
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
                                        backgroundColor: objColorsApp.celeste,
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

              return Center(
                child: Container(
                  color: Colors.transparent,
                  child: Image.asset('assets/gifs/gif_carga.gif'),
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(                
        onPressed: () {
          terminoBusqueda = '';
          filtroPrspTxt = TextEditingController();
          //context.push(objRutasGen.rutaRegistroPrsp);          
        },
        backgroundColor: const Color.fromRGBO(75, 57, 239, 1.0),
        child: const Icon(Icons.person_add_alt, color: Colors.white,),
      ),
    );
  }
}
