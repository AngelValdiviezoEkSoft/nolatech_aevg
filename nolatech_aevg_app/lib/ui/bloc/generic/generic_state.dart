part of 'generic_bloc.dart';

class GenericState extends Equatable {

  final storage = const FlutterSecureStorage();
  final int positionMenu;
  final int positionFormaPago;
  final double coordenadasMapa;
  final double radioMarcacion;
  final String formaPago;
  final String localidadId;
  final String idFormaPago;
  final double heightModalPlanAct;
  final bool muestraCarga;

  const GenericState(
    {
      positionMenu = 0,
      positionFormaPago = 0,
      coordenadasMapa = 0,
      radioMarcacion = 0,
      formaPago = 'C',
      localidadId = '',
      idFormaPago = '',
      heightModalPlanAct = 0.65,
      muestraCarga,
    } 
  ) : positionMenu = positionMenu ?? 0,
      positionFormaPago = positionFormaPago ?? 0,
      coordenadasMapa = coordenadasMapa ?? 0,
      radioMarcacion = radioMarcacion ?? 0,
      formaPago = formaPago ?? 'C',
      localidadId = localidadId ?? '',
      idFormaPago = idFormaPago ?? '',
      heightModalPlanAct = heightModalPlanAct ?? 0.65,
      muestraCarga = muestraCarga ?? false;
  

  GenericState copyWith({
    int? positionMenu,
    int? positionFormaPago,
    double? coordenadasMapa,
    double? radioMarcacion,
    String? formaPago,
    String? localidadId,
    String? idFormaPago,
    double? heightModalPlanAct,
    bool? muestraCarga
  }) 
  => GenericState(
    positionMenu: positionMenu ?? this.positionMenu,
    positionFormaPago: positionFormaPago ?? this.positionFormaPago,
    coordenadasMapa: coordenadasMapa ?? this.coordenadasMapa,
    radioMarcacion: radioMarcacion ?? this.radioMarcacion,
    formaPago: formaPago ?? this.formaPago,
    localidadId: localidadId ?? this.localidadId,
    idFormaPago: idFormaPago ?? this.idFormaPago,
    heightModalPlanAct: heightModalPlanAct ?? this.heightModalPlanAct,
    muestraCarga: muestraCarga ?? this.muestraCarga
  );


  @override
  List<Object> get props => [positionMenu,positionFormaPago,coordenadasMapa,radioMarcacion,formaPago,localidadId,idFormaPago, heightModalPlanAct, muestraCarga];

  Future<String> readPrincipalPage() async {

    try{
      final items = <ItemBoton>[
        
        ItemBoton('','','',1, Icons.group_add, 'Epic Box', '6 de julio 2024','Reservado por: Andrea Gómez','2 horas', Colors.white, Colors.white,false,false,'\$5','','icCompras.png','icComprasTrans.png','',
          '', 
          () {
            
          }
        ),
        
        ItemBoton('','','',2, Icons.groups, 'Epic Box', '8 de agosto 2024','Reservado por: Angel Valdiviezo','5 horas', Colors.white, Colors.white,false,false,'\$84','','icTramApr.png','icTramAprTrans.png','',
          '', 
          () {
            
          }
        ),
        
        ItemBoton('','','',3, Icons.calendar_month, 'Epic Box', '20 noviembre 2024','Reservado por: Fulanito','6 horas', Colors.white, Colors.white,false,false,'\$110','','icTramProc.png','icTramProcTrans.png','',
          '', 
          () {}
        ),
      ]; 

      final itemsCanchas = <CanchasModel>[
        CanchasModel(id: 1, date: '6 de julio 2024', description: 'Cancha tipo A', value: '\$5', like: false, title: 'Epic Box', image: 'assets/images/court_epicbox.png', range: '7:00 am a 4:00 pm'),
        CanchasModel(id: 2, date: '8 de agosto 2024', description: 'Cancha tipo B', value: '\$15', like: false, title: 'Epic Box', image: 'assets/images/court_sportbox.png', range: '9:00 am a 2:00 pm'),
        CanchasModel(id: 3, date: '20 de noviembre 2024', description: 'Cancha tipo C', value: '\$25', like: false, title: 'Epic Box', image: 'assets/images/court_epicbox.png', range: '11:00 am a 6:00 pm'),
        /*
        ItemBoton('assets/images/court_epicbox.png','Epic Box','Cancha tipo A',1, Icons.group_add, '7:00 am a 4:00 pm', '6 de julio 2024','Reservado por: Andrea Gómez','2 horas', Colors.white, Colors.white,false,false,'\$5','','icCompras.png','icComprasTrans.png','',
          '', 
          () {
            
          }
        ),
        
        ItemBoton('assets/images/court_sportbox.png','Sport Box','Cancha tipo B',2, Icons.groups, '9:00 am a 2:00 pm', '8 de agosto 2024','Reservado por: Angel Valdiviezo','5 horas', Colors.white, Colors.white,false,false,'\$84','','icTramApr.png','icTramAprTrans.png','',
          '', 
          () {
            
          }
        ),
        
        ItemBoton('assets/images/court_epicbox.png','Epic Box 2','Cancha tipo C',3, Icons.calendar_month, '11:00 am a 6:00 pm', '20 noviembre 2024','Reservado por: Fulanito','6 horas', Colors.white, Colors.white,false,false,'\$110','','icTramProc.png','icTramProcTrans.png','',
          '', 
          () {}
        ),
        */
      ]; 

      const storage = FlutterSecureStorage();

      final jsonString = serializeItemBotonMenuList(items);
      final jsonStringCanchas = serializeItemCanchasList(itemsCanchas);

      String nombreLogueado = await storage.read(key: 'UsuarioLog') ?? '';

      return '$jsonString---$jsonStringCanchas---$nombreLogueado';
    }
    catch(ex){
      return '';
    }
  }

    Future<String> readCanchas() async {

    try{

      final itemsCanchas = <ItemBoton>[
        
        ItemBoton('assets/images/court_epicbox.png','Epic Box','Cancha tipo A',1, Icons.group_add, '7:00 am a 4:00 pm', '6 de julio 2024','Reservado por: Andrea Gómez','2 horas', Colors.white, Colors.white,false,false,'\$5','','icCompras.png','icComprasTrans.png','',
          '', 
          () {
            
          }
        ),
        
        ItemBoton('assets/images/court_sportbox.png','Sport Box','Cancha tipo B',2, Icons.groups, '9:00 am a 2:00 pm', '8 de agosto 2024','Reservado por: Angel Valdiviezo','5 horas', Colors.white, Colors.white,false,false,'\$84','','icTramApr.png','icTramAprTrans.png','',
          '', 
          () {
            
          }
        ),
        
        ItemBoton('assets/images/court_epicbox.png','Epic Box 2','Cancha tipo C',3, Icons.calendar_month, '11:00 am a 6:00 pm', '20 noviembre 2024','Reservado por: Fulanito','6 horas', Colors.white, Colors.white,false,false,'\$110','','icTramProc.png','icTramProcTrans.png','',
          '', 
          () {}
        ),
      ]; 

      final jsonStringCanchas = serializeItemBotonMenuList(itemsCanchas);

      //respCmbLst = '$rspRegistro---${json.encode(lstRsp)}---$jsonString---${objPermisos.mainMenu.cardSales}---${objPermisos.mainMenu.cardCollection}';

      return jsonStringCanchas;
    }
    catch(ex){
      return '';
    }
  }


  Future<String> waitCarga() async {
    
    return await Future.delayed(
      const Duration(milliseconds: 2500), 
        () => 'ok'
      ); 
  }
  
  readCombosGen() async {
    
    String cmbCamp = await storage.read(key: 'cmbCampania') ?? '';
    String cmbOrigen = await storage.read(key: 'cmbOrigen') ?? '';
    String cmbMedia = await storage.read(key: 'cmbMedia') ?? '';
    String cmbAct = await storage.read(key: 'cmbActividades') ?? '';
    String cmbPais = await storage.read(key: 'cmbPaises') ?? '';
    String cmbLstAct = await storage.read(key: 'cmbLstActividades') ?? '';

    return "$cmbCamp---$cmbOrigen---$cmbMedia---$cmbAct---$cmbPais---$cmbLstAct";
  }

  readDatosPerfil() async {    
    String objLogin = await storage.read(key: 'RespuestaLogin') ?? '';

    return objLogin;
  }

  
  Future<String> lstProspectos() async {
    var rsp = await storage.read(key: 'RespuestaProspectos') ?? '';
    //print('Lst Prsp: $rsp');
    return rsp;
  }

  Future<String> lstClientes() async {
    var rsp = await storage.read(key: 'RespuestaClientes') ?? '';    
    return rsp;
  }
  
  Map<String, dynamic> serializeItemBotonMenu(ItemBoton item) {
    return {
      'tipoNotificacion': item.tipoNotificacion,
      'idSolicitud': item.idSolicitud,
      'idNotificacionGen': item.idNotificacionGen,
      'ordenNot': item.ordenNot,
      'icon': item.icon.codePoint,
      'mensajeNotificacion': item.mensajeNotificacion,
      'mensaje2': item.mensaje2,
      'fechaNotificacion': item.fechaNotificacion,
      'tiempoDesde': item.tiempoDesde,
      'color1': item.color1.value,
      'color2': item.color2.value,
      'requiereAccion': item.requiereAccion,
      'esRelevante': item.esRelevante,
      'estadoLeido': item.estadoLeido,
      'numIdenti': item.numIdenti,
      'iconoNotificacion': item.iconoNotificacion,
      'rutaImagen': item.rutaImagen,
      'idTransaccion': item.idTransaccion,
      'rutaNavegacion': item.rutaNavegacion,
    };
  }

  String serializeItemBotonMenuList(List<ItemBoton> items) {    
    final serializedList = items.map((item) => serializeItemBotonMenu(item)).toList();

    return jsonEncode(serializedList);
  }

  List<ItemBoton> deserializeItemBotonMenuList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => deserializeItemBotonMenu(json)).toList();
  }

//

  String serializeItemCanchasList(List<CanchasModel> items) {    
    final serializedList = items.map((item) => serializeItemCanchasModel(item)).toList();

    return jsonEncode(serializedList);
  }

    Map<String, dynamic> serializeItemCanchasModel(CanchasModel item) {
    return {
      'id': item.id,
      'date': item.date,
      'description': item.description,
      'image': item.image,
      'like': item.like,
      'range': item.range,
      'title': item.title,
      'value': item.value
    };

  }

    ItemBoton deserializeItemBotonMenu(Map<String, dynamic> json) {
    IconData iconData;
    
    try{
      iconData = IconData(
        json['icon'],
        fontFamily: 'MaterialIcons',
      );
    }
    catch(_){
      iconData = Icons.abc;
    }
    
    return ItemBoton(
      json['tipoNotificacion'] ?? '',
      json['idSolicitud'] ?? '',
      json['idNotificacionGen'] ?? '',
      json['ordenNot'] ?? 0,
      iconData,
      json['mensajeNotificacion'] ?? '',
      json['mensaje2'] ?? '',
      json['fechaNotificacion'] ?? '',
      json['tiempoDesde'] ?? '',
      Color(json['color1'] ?? 0),
      Color(json['color2'] ?? 0),
      json['requiereAccion'] ?? false,
      json['esRelevante'] ?? false,
      json['estadoLeido'] ?? '',
      json['numIdenti'] ?? '',
      json['iconoNotificacion'] ?? '',
      json['rutaImagen'] ?? '',
      json['idTransaccion'] ?? '',
      json['rutaNavegacion'] ?? '',
      () {},
    );
  
  }


  List<CanchasModel> deserializeItemCanchasList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => deserializeCanchasModel(json)).toList();
  }

  CanchasModel deserializeCanchasModel(Map<String, dynamic> json) {
    
    return CanchasModel(
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      like: json['like'] ?? false,
      range: json['range'] ?? '',
      title: json['title'] ?? '',
      value: json['value'] ?? ''      
    );
  
  }



}

