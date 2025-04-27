import 'dart:async';
import 'dart:convert';

import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

//late Timer _timer;

class AuthService extends ChangeNotifier {
  
  final storage = const FlutterSecureStorage();
  List<OpcionesMenuModel> lstOp = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String passWord = '';
  String email = '';
  bool _areInputsView = false;
  bool _inputPin = false;

  bool get areInputsView => _areInputsView;
  set areInputsView(bool value) {
    _areInputsView = value;
    notifyListeners();
  }

  bool get inputPin => _inputPin;
  set inputPin(bool value) {
    _inputPin = value;
    notifyListeners();
  }

  bool isLoading = false;
  bool get varIsLoading => isLoading;
  set varIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isLoadingCambioClave = false;
  bool get varIsLoadingCambioClave => isLoadingCambioClave;
  set varIsLoadingCambioClave(bool value) {
    isLoadingCambioClave = value;
    notifyListeners();
  }

  String varCedula = '';
  String varPasaporte = '';

  bool isKeyOscured = true;
  bool get varIsKeyOscured => isKeyOscured;
  set varIsKeyOscured(bool value) {
    isKeyOscured = value;
    notifyListeners();
  }

  bool isOscured = true;
  bool get varIsOscured => isOscured;
  set varIsOscured(bool value) {
    isOscured = value;
    notifyListeners();
  }

  bool isOscuredConf = true;
  bool get varIsOscuredConf => isOscuredConf;
  set varIsOscuredConf(bool value) {
    isOscuredConf = value;
    notifyListeners();
  }

  bool isOscuredConfNew = true;
  bool get varIsOscuredConfNew => isOscuredConfNew;
  set varIsOscuredConfNew(bool value) {
    isOscuredConfNew = value;
    notifyListeners();
  }

  bool isPasaporte = false;
  bool get varIsPasaporte => isPasaporte;
  set varIsPasaporte(bool value) {
    isPasaporte = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  login(AuthRequest authRequest) async {
    try {

      String rsp = '';

      String resInt = await ValidacionesUtils().validaInternet();

      if(resInt.isNotEmpty){
        return 'NI';
      }

      //await storage.write(key: 'UsuarioLog', value: authRequest.login);

      bool esUserValido = false;

      var lstUserReg = await storage.read(key: 'UserReg') ?? '';

      var lstExistenteUsers = deserializeUserReg(lstUserReg);
        
      for(int i = 0; i < lstExistenteUsers.length; i++){
        if( lstExistenteUsers[i].email == authRequest.login 
            && lstExistenteUsers[i].password == authRequest.password){
          esUserValido = true;
          await storage.delete(key: 'UsuarioLog');
          await storage.write(key: 'UsuarioLog', value: lstExistenteUsers[i].nombres);
        }
      }

      if(!esUserValido){
        rsp = 'Usuario inválido';
      }
      else{
        rsp = 'OK';
      }

      return rsp;//response.body;
    } catch (_) {
      //print('Test Error1: $ex');
    }
  }

  
  Future<String> registraUser(UserAppModel userNew) async {
    
    bool esRepetido = false;
    String rsp = 'Usuario Creado Exitosamente';
    const storage = FlutterSecureStorage();
    List<UserAppModel> lstUsuarios = [];

    var lstUserReg = await storage.read(key: 'UserReg') ?? '';

    if(lstUserReg.isEmpty){
      lstUsuarios.add(userNew);
    }
    else{
      var lstExistenteUsers = deserializeUserReg(lstUserReg);
      
      for(int i = 0; i < lstExistenteUsers.length; i++){
        if(lstExistenteUsers[i].email == userNew.email 
        || lstExistenteUsers[i].nombres == userNew.nombres 
        || lstExistenteUsers[i].tlf == userNew.tlf){
          esRepetido = true;
        }
      }

      if(esRepetido){
        //lstExistenteUsers.add(userNew);
        rsp = 'Usuario Repetido';
      }
    }

    if(!esRepetido){
      final jsonRegistros = serializeRegistroUsuarios(lstUsuarios);

      storage.write(key: 'UserReg', value: jsonRegistros);
      storage.write(key: 'UsuarioLog', value: userNew.nombres);
    }

    return rsp;
  }

  String serializeRegistroUsuarios(List<UserAppModel> items) {    
    final serializedList = items.map((item) => serializeUserReg(item)).toList();

    return jsonEncode(serializedList);
  }

  Map<String, dynamic> serializeUserReg(UserAppModel item) {
    return {
      'nombres': item.nombres,
      'email': item.email,
      'tlf': item.tlf,
      'password': item.password,
      
    };
  }

  
  List<UserAppModel> deserializeUserReg(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => deserializeItemUserReg(json)).toList();
  }

  UserAppModel deserializeItemUserReg(Map<String, dynamic> json) {
    
    return UserAppModel(
      email: json['email'] ?? '',
      nombres: json['nombres'] ?? '',
      password: json['password'] ?? '',
      tlf: json['tlf'] ?? ''
    );
  
  }

/*
  consultaUsuarios(ConsultaDatosRequestModel authRequest, String imei, String key) async {
    final ruta = '${env.apiEndpoint}<imei>/done/data/<model>/model';
    
     final response = await http.post(
      Uri.parse(ruta),
      headers: <String, String>{
        'Content-Type': EnvironmentsProd().contentType,
      },
      body: jsonEncode(
        <String, String>
        {
          "key": authRequest.key,
          "tocken": authRequest.token,
          "imei": authRequest.imei,
          "uid": authRequest.uid,
          "company": authRequest.company,
          "bearer": authRequest.bearer,
          "tocken_valid_date": authRequest.tokenValidDate,
          //"filters": objRegister.so  //PEDIR EJEMPLO
        }
      ),
    );
    
    var reponseRs = response.body;

    var rspValidacion = json.decode(response.body);

    if(rspValidacion['result']['mensaje'] == 'El tocken no es valido'){
      await tokenManager.checkTokenExpiration();
      await consultaUsuarios(authRequest,imei, key);
    }

    return RegisterDeviceResponseModel.fromJson(reponseRs);
    
  }
  */
  Future<dynamic> opcionesMenuPorPerfil(BuildContext context) async {

    var objLogin = await storage.read(key: 'RespuestaLogin') ?? '';

    final data = json.decode(objLogin);

    lstOp = [
      /*
      OpcionesMenuModel(
        descMenu: 'Editar Perfil', 
        icono: Icons.person_pin, 
        onPress: () => context.push(RoutesDesc().rutaEditarPerfil),
      ),
      */
      OpcionesMenuModel(
        descMenu: 'Soporte', 
        icono: Icons.question_mark,
        onPress: () async =>  await launchUrl(Uri.parse(data["result"]["done_support_url"]), mode: LaunchMode.externalApplication),
      ),
      OpcionesMenuModel(
        descMenu: 'Términos de uso',
        icono: Icons.info,
        onPress: () async =>  await launchUrl(Uri.parse(data["result"]["done_terms_of_use_url"]), mode: LaunchMode.externalApplication),
      ),
    ];
    return lstOp;
  }

  Future logOut() async {
    await storage.write(key: 'RecordarContrasenia', value: '');
    
    return;
  }

}
