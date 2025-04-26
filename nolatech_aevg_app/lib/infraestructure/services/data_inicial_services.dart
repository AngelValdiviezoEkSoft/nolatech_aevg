
import 'dart:convert';

import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/infraestructure/infraestructure.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storageDataInicial = FlutterSecureStorage();

class DataInicialService extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  readModelosApp(List<Map<String, dynamic>> modelo) async {
    try {

      var codImei = await storageDataInicial.read(key: 'codImei') ?? '';

      var objReg = await storageDataInicial.read(key: 'RespuestaRegistro') ?? '';
/*
      var obj = RegisterDeviceResponseModel.fromJson(objReg);

      var objLog = await storageDataInicial.read(key: 'RespuestaLogin') ?? '';
      var objLogDecode = json.decode(objLog);

      ConsultaMultiModelRequestModel objReq = ConsultaMultiModelRequestModel(
        jsonrpc: EnvironmentsProd().jsonrpc,
        params: ParamsMultiModels(
          bearer: obj.result.bearer,
          company: objLogDecode['result']['current_company'],
          imei: codImei,
          key: obj.result.key,
          tocken: obj.result.tocken,
          tockenValidDate: obj.result.tockenValidDate,
          uid: objLogDecode['result']['uid'],
          models: []
        )
      );
      */

      //await GenericService().getMultiModelosGen(objReq, modelo);
      
    }
    catch(_){
      //print('Test DataInit $ex');
    }
  }
  
  readCombosProspectos() async {

    try{
/*
      var objPaises = await PaisService().getPaises();

      await storageDataInicial.write(key: 'cmbPaises', value: json.encode(objPaises));
      */

    }
    catch(ex){
      //print('TST init: $ex');
    }
  }

  Future<String> readPrincipalPage() async {

    try{
      final registraProspecto = await storageDataInicial.read(key: 'registraProspecto') ?? '';
      
      var connectivityResult = await ValidacionesUtils().validaInternet();

      String rspRegistro = '';

      if(registraProspecto.isNotEmpty && connectivityResult.isEmpty){
        var objReg = jsonDecode(registraProspecto);

        await storageDataInicial.delete(key: 'registraProspecto');

        rspRegistro = 'G';
      }

      final resp = await storageDataInicial.read(key: 'RespuestaLogin') ?? '';

      final data = json.decode(resp);
      final objTmp = data['result'];
      final lstFinal = objTmp['allowed_companies'];
      final objPermisosTmp = objTmp['done_permissions'];

      Map<String, dynamic> dataTmp = json.decode(json.encode(lstFinal));

      List<String> lstRsp = [];

      dataTmp.forEach((key, value) {
        if(key == objTmp['current_company'].toString()){
          lstRsp.add(value['name']);
        }
      });

      dataTmp.forEach((key, value) {
        if(key != objTmp['current_company'].toString()){                  
          lstRsp.add(value['name']);
        }
      });

      String respCmbLst = '';


      final items = <ItemBoton>[
        /*
        ItemBoton('','','',1, Icons.group_add, 'Prospectos', 'Seguimiento y control de prospectos','','', Colors.white, Colors.white,false,false,'','','icCompras.png','icComprasTrans.png','',
          RoutesDesc().rutaListaProspectos, 
          () {
            
          }
        ),
        */
      ]; 
/*
      var rspCli = await ClienteService().getClientes();

      await storageDataInicial.write(key: 'RespuestaClientes', value: rspCli);
      */
      
      final jsonString = serializeItemBotonMenuList(items);      

      respCmbLst = '$rspRegistro---${json.encode(lstRsp)}---$jsonString';

      return respCmbLst;
    }
    catch(ex){
      //print('Error gen: $ex');
      return '';
    }
  }

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

