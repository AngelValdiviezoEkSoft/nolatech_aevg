
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

TextEditingController namesTxt = TextEditingController();
TextEditingController passWordNewTxt = TextEditingController();

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
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView(      
      children: [
        
        Stack(
          children: [
            ClipPath(
              clipper: BottomCurveClipperRecord(),
              child: Image.asset(
                'assets/images/tennis_bg.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
                ),
              ),
              
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),          
          child: Column(children: [
            const Text(
          'Registro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 30),

        TextField(
          keyboardType: TextInputType.text,
            decoration: InputDecoration(
            labelText: 'Nombre y apellido',
            //hintText: 'usuario@email.com',
            prefixIcon: const Icon(Icons.person),
            border: const UnderlineInputBorder(),
          ),
        ),

        TextField(
          keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'usuario@email.com',
            prefixIcon: const Icon(Icons.email_outlined),
            border: const UnderlineInputBorder(),
          ),
        ),

        TextField(
          keyboardType: TextInputType.phone,
            decoration: InputDecoration(
            labelText: 'Teléfono',
            hintText: 'usuario@email.com',
            prefixIcon: const Icon(Icons.phone),
            border: const UnderlineInputBorder(),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[400],
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
                child: const Text(
                  " Iniciar sesión",
                  style: TextStyle(
                    color: Colors.blue,
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
