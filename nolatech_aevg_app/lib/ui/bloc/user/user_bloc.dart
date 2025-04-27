
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  
  //String _pin = '';

  UserBloc() : super(const UserState(
    positionMenu: 0
  )) {    
    on<RegisterUserEvent>(_onRegisterUserEvent);    
  }

  void _onRegisterUserEvent(RegisterUserEvent event, Emitter<UserState> emit) async {
    try {
      
    } catch (e) {
      //emit(AuthError(e.toString()));
    }
  }

  Future<String> setRegistraUser(UserAppModel userNew) async {
    
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
      
      for(int i = 0; i <= lstExistenteUsers.length; i++){
        if(lstExistenteUsers[i].email == userNew.email 
        || lstExistenteUsers[i].nombres == userNew.nombres 
        || lstExistenteUsers[i].password == userNew.password 
        || lstExistenteUsers[i].tlf == userNew.tlf){
          esRepetido = true;
        }
      }

      if(!esRepetido){
        lstExistenteUsers.add(userNew);
        rsp = 'Usuario Repetido';
      }
    }

    if(!esRepetido){
      final jsonRegistros = serializeRegistroUsuarios(lstUsuarios);

      storage.write(key: 'UserReg', value: jsonRegistros);
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


}
