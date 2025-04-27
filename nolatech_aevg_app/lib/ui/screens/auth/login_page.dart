import 'package:auto_size_text/auto_size_text.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/infraestructure/infraestructure.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';

TextEditingController userTxt = TextEditingController();
TextEditingController passWordTxt = TextEditingController();

const storageAuth = FlutterSecureStorage();
BuildContext? contextAuth;
String tokenDevice = '';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<AuthScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

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
            'Iniciar sesión',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 30),

        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: userTxt,
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

        const SizedBox(height: 20),

        TextField(
          obscureText: _obscurePassword,
          controller: passWordTxt,
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

      const SizedBox(height: 10),

        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
            const Text("Recordar contraseña"),
          ],
        ),
        const SizedBox(height: 5),
        
        Align(
          alignment: Alignment.center,
          child: TextButton(
          onPressed: () {},
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(color: ColorsApp().azulLabelLogin),
          ),
        ),
        ),

        const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {

                if(userTxt.text.isEmpty || passWordTxt.text.isEmpty){
                  
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
                            mensajeAlerta: 'Ingrese sus credenciales.'
                          );
                        },
                      );

                  return;
                }

                if(!ValidacionesUtils().isValidEmail(userTxt.text)){
                  
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
                            mensajeAlerta: 'Email inválido.'
                          );
                        },
                      );

                  return;
                }

                AuthRequest objAuthRequest = AuthRequest(
                  db: '',
                  login: userTxt.text,
                  password: passWordTxt.text
                );

                var resp = await AuthService().login(objAuthRequest);

                if(resp == 'NI'){
                  //ignore: use_build_context_synchronously
                  context.pop();

                  showDialog(
                    //ignore: use_build_context_synchronously
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Container(
                          color: Colors.transparent,
                          height: size.height * 0.22,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Container(
                                color: Colors.transparent,
                                height: size.height * 0.1,
                                child: Image.asset('assets/gifs/gifErrorBlanco.gif'),
                              ),

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.95,
                                height: size.height * 0.11,
                                alignment: Alignment.center,
                                child: const AutoSizeText(
                                  'No tiene acceso a internet',
                                  maxLines: 2,
                                  minFontSize: 2,
                                ),
                              ),
                              
                            ],
                          )
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar', style: TextStyle(color: Colors.blue[200]),),
                          ),
                        ],
                      );
                    },
                  );
                
                  return;
                }

                if(resp == 'OK'){
                  const storage = FlutterSecureStorage();
                
                  storage.write(key: 'RecordarContrasenia', value: '$_rememberMe');

                  userTxt.text = '';
                  passWordTxt.text = '';

                  //ignore: use_build_context_synchronously
                  context.push(RoutesDesc().rutaPrincipal);
                }
                else{
                    showDialog(
                    //ignore: use_build_context_synchronously
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Container(
                          color: Colors.transparent,
                          height: size.height * 0.22,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Container(
                                color: Colors.transparent,
                                height: size.height * 0.1,
                                child: Image.asset('assets/gifs/gifErrorBlanco.gif'),
                              ),

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.95,
                                height: size.height * 0.11,
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  resp,
                                  maxLines: 2,
                                  minFontSize: 2,
                                ),
                              ),
                              
                            ],
                          )
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar', style: TextStyle(color: Colors.blue[200]),),
                          ),
                        ],
                      );
                    },
                  );
                
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp().verdeApp,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("¿Aún no tienes cuenta? "),
              GestureDetector(
                onTap: () {
                  context.push(RoutesDesc().rutaRegistro);
                },
                child: Text(
                  "Regístrate",
                  style: TextStyle(
                    color: ColorsApp().azulLabelLogin,
                    fontWeight: FontWeight.w600, 
                  ),
                ),
              )
            ],
          ),
        
          ],)
        ),

        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(2, size.height - 270); // Baja hasta casi el final
    path.quadraticBezierTo(
      size.width / 4, size.height, // Punto de control para la curva
      size.width, size.height - 80, // Punto final de la curva
    );
    path.lineTo(size.width, 0); // Sube al tope derecho
    path.close(); // Cierra el camino
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
