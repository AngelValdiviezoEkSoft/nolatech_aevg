/*
part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}
*/

part of 'user_bloc.dart';

class UserState extends Equatable {
  
  final storage = const FlutterSecureStorage();
  final int positionMenu;  

  const UserState(
    {
      positionMenu = 0      
    } 
  ) : positionMenu = positionMenu ?? 0;
  

  UserState copyWith({
    int? positionMenu
  }) 
  => UserState(
    positionMenu: positionMenu ?? this.positionMenu
  );


  @override
  List<Object> get props => [positionMenu];
  
  Future<String> readToken() async {
    try {
      String rspFinal = 'home';

      var recPassword = await storage.read(key: 'RecordarContrasenia') ?? '';
                
      var termCond = await storage.read(key: 'AceptaTermCond');

      await storage.write(key: 'fecMem', value: '');
      await storage.write(key: 'idMem', value: '');

      if(recPassword.isEmpty || recPassword == 'false'){
        rspFinal = '';
      }
      else {
        
        if(recPassword == 'true'){
          rspFinal = 'home';
        }        
      }
      
      return rspFinal; 
    }
    catch(ex) {
      return '';
    }
    
  }

}

