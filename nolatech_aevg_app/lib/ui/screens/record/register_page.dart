import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/infraestructure/infraestructure.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

late TextEditingController namesTxt;
late TextEditingController emailTxt;
late TextEditingController tlfTxt;
late TextEditingController passWordReg;
late TextEditingController passWordNewTxt;

//const storageAuth = FlutterSecureStorage();
BuildContext? contextRecord;

class FrmRecordScreen extends StatefulWidget {
  const FrmRecordScreen({super.key});

  @override
  State<FrmRecordScreen> createState() => _FrmRecordScreenState();
}

class _FrmRecordScreenState extends State<FrmRecordScreen> {
  bool _obscurePassword = true;
  bool _obscureConfPassword = true;
  //bool _rememberMe = false;

  @override
  void initState() {    
    super.initState();

    namesTxt = TextEditingController();
    emailTxt = TextEditingController();
    tlfTxt = TextEditingController();
    passWordReg = TextEditingController();
    passWordNewTxt = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
    body: ListView(      
      children: [
        
        Stack(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Image.asset(
                'assets/images/curva_login.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
                ),
              ),
              
              Positioned(
                top: 30,
                left: 22,
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    width: size.width * 0.1,
                    height: size.height * 0.045,
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/btn_atras.png',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      ),
                  ),
                ),
              ),
            ],
          ),


        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),          
          child: Column(children: [
            
        Container(
          color: Colors.transparent,
          width: size.width * 0.95,
          child: const Text(
            'Registro',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

/*
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 1),          
          child: Column(children: [
            const Text(
          'Registro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        */

        const SizedBox(height: 30),

        TextField(
          controller: namesTxt,
          keyboardType: TextInputType.text,
            decoration: const InputDecoration(
            labelText: 'Nombre y apellido',
            //hintText: 'usuario@email.com',
            prefixIcon: Icon(Icons.person),
            border: UnderlineInputBorder(),
          ),
        ),

        TextFormField(
          controller: emailTxt,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'usuario@email.com',
            prefixIcon: Icon(Icons.email_outlined),
            border: UnderlineInputBorder(),
          ),          
          validator: (value) {
            if (value != null && value.isNotEmpty && !ValidacionesUtils().isValidEmail(value)) {              
              return 'Correo Inválido';
            }
            return '';
          },
        ),

        TextField(
          controller: tlfTxt,
          keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
            labelText: 'Teléfono',
            hintText: 'xxx xxx xxxx',
            prefixIcon: Icon(Icons.phone),
            border: UnderlineInputBorder(),
          ),
        ),

        SizedBox(height: size.height * 0.008),

        TextField(
          controller: passWordReg,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          border: const UnderlineInputBorder(),
        ),
      ),

        TextField(
          controller: passWordNewTxt,
          obscureText: _obscureConfPassword,
          decoration: InputDecoration(
            labelText: 'Confirmar contraseña',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
              setState(() {
                _obscureConfPassword = !_obscureConfPassword;
              });
            },
          ),
          border: const UnderlineInputBorder(),
        ),
      ),

      const SizedBox(height: 50),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if(namesTxt.text.isEmpty || emailTxt.text.isEmpty || tlfTxt.text.isEmpty || passWordReg.text.isEmpty || passWordNewTxt.text.isEmpty){
                  showDialog(
                        barrierDismissible: false,
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
                            numLineasTitulo: 2,
                            numLineasMensaje: 2,
                            titulo: 'Error',
                            mensajeAlerta: 'Ingrese los datos solicitados.'
                          );
                        },
                      );

                  return;
                }

                if(passWordReg.text != passWordNewTxt.text){
                  showDialog(
                    barrierDismissible: false,
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
                        numLineasTitulo: 2,
                        numLineasMensaje: 2,
                        titulo: 'Error',
                        mensajeAlerta: 'Las contraseñas no coinciden.'
                      );
                    },
                  );

                  return;
                }
                
                if(!ValidacionesUtils().isValidEmail(emailTxt.text)){
                  showDialog(
                    barrierDismissible: false,
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
                        numLineasTitulo: 2,
                        numLineasMensaje: 2,
                        titulo: 'Error',
                        mensajeAlerta: 'Formato de correo inválido.'
                      );
                    },
                  );

                  return;
                }

                UserAppModel objReg = UserAppModel(
                  email: emailTxt.text,
                  nombres: namesTxt.text,
                  password: passWordReg.text,
                  tlf: tlfTxt.text
                );

                var resp = await AuthService().registraUser(objReg);
                String cabMsm = '';

                if(resp == 'Usuario Repetido'){
                  cabMsm = 'Error';

                }
                else{
                  cabMsm = 'Éxito';
                }

                showDialog(
                  barrierDismissible: false,
                  //ignore: use_build_context_synchronously
                  context: context,
                  builder: (BuildContext context) {
                    return ContentAlertDialog(
                      onPressed: () async {
                        if(cabMsm == 'Error'){
                          Navigator.of(context).pop();
                        }
                        else {
                          Navigator.of(context).pop();
                          
                          const storage = FlutterSecureStorage();
                
                          storage.write(key: 'RecordarContrasenia', value: 'false');

                          AuthRequest objAuthRequest = AuthRequest(
                            db: '',
                            login: emailTxt.text,
                            password: passWordReg.text
                          );


                          await AuthService().login(objAuthRequest);

                          //ignore: use_build_context_synchronously
                          context.push(RoutesDesc().rutaPrincipal);
                        }
                      },
                      onPressedCont: () async {
                        if(cabMsm == 'Error'){
                          Navigator.of(context).pop();
                        }
                        else {
                          //Navigator.of(context).pop();
                          
                          const storage = FlutterSecureStorage();
                
                          storage.write(key: 'RecordarContrasenia', value: 'false');

                          AuthRequest objAuthRequest = AuthRequest(
                            db: '',
                            login: emailTxt.text,
                            password: passWordReg.text
                          );

                          await AuthService().login(objAuthRequest);

                          //ignore: use_build_context_synchronously
                          context.push(RoutesDesc().rutaPrincipal);
                        }
                      },
                      tipoAlerta: TipoAlerta().alertAccion,
                      numLineasTitulo: 2,
                      numLineasMensaje: 2,
                      titulo: cabMsm,
                      mensajeAlerta: resp
                    );
                  },
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp().verdeBtnInicio,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ), 
              child: const Text(
                'Registrarme',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Ya tengo cuenta"),
              GestureDetector(
                onTap: () {
                  // Navegar a registro
                },
                child: Text(
                  " Iniciar sesión",
                  style: TextStyle(
                    color: ColorsApp().azulLabelLogin,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        
          ],),
        ),

        
        ],
      ),
    );
  }
}

class BottomCurveClipperRecord extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 270); // Baja hasta casi el final
    path.quadraticBezierTo(
      size.width / 5, size.height, // Punto de control para la curva
      size.width, size.height - 100, // Punto final de la curva
    );
    path.lineTo(size.width, 0); // Sube al tope derecho
    path.close(); // Cierra el camino
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
