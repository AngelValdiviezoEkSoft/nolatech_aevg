
import 'dart:convert';

import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class CanchasService extends ChangeNotifier {
  
  final storage = const FlutterSecureStorage();

  Future<String> listaCanchasFavoritas() async {
    var lstUserReg = await storage.read(key: 'CanchasFavReg') ?? '';

    return lstUserReg;

  }
  
  Future<String> registraCanchasFavoritas(CanchasModel userNew) async {
    
    String rsp = 'Cancha Marcada como favorita';
    const storage = FlutterSecureStorage();
    List<CanchasModel> lstUsuarios = [];

    var lstUserReg = await storage.read(key: 'CanchasFavReg') ?? '';

    if(lstUserReg.isEmpty){
      lstUsuarios.add(userNew);
    }
    else{
      var lstExistenteUsers = deserializeUserReg(lstUserReg);

      for(int i = 0; i < lstExistenteUsers.length; i++){
        if(lstExistenteUsers[i].id != userNew.id){
          lstUsuarios.add(userNew);
        }
        else {
          if(lstExistenteUsers[i].id == userNew.id && lstExistenteUsers[i].like == userNew.like){
            lstUsuarios.add(lstExistenteUsers[i]);
          }
        }
      }
      
    }

    final jsonRegistros = serializeRegistroUsuarios(lstUsuarios);

    storage.write(key: 'CanchasFavReg', value: jsonRegistros);

    return rsp;
  }

  String serializeRegistroUsuarios(List<CanchasModel> items) {    
    final serializedList = items.map((item) => serializeUserReg(item)).toList();

    return jsonEncode(serializedList);
  }

  Map<String, dynamic> serializeUserReg(CanchasModel item) {
    return {
      'id': item.id,
      'date': item.date,
      'description': item.description,
      'title': item.title,
      'value': item.value,      
      'image': item.image,
      'range': item.range
    };
  }

  List<CanchasModel> deserializeUserReg(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => deserializeItemUserReg(json)).toList();
  }

  CanchasModel deserializeItemUserReg(Map<String, dynamic> json) {
    
    return CanchasModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      value: json['value'] ?? '',
      like: json['like'] ?? false,
      image: json['image'] ?? '',
      range: json['range'] ?? '',
      
    );
  
  }
}
