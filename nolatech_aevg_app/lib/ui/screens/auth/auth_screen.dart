import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nolatech_aevg_app/config/config.dart';
import 'package:nolatech_aevg_app/domain/models/models.dart';
import 'package:nolatech_aevg_app/infraestructure/infraestructure.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        
        Stack(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
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
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ],
          ),

        const SizedBox(height: 10),

        const Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 30),

        TextField(
          keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'usuario@email.com',
            prefixIcon: const Icon(Icons.email_outlined),
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
          alignment: Alignment.centerRight,
          child: TextButton(
          onPressed: () {},
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        ),

        const SizedBox(height: 10),

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
                  // Navegar a registro
                },
                child: const Text(
                  "Regístrate",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
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
    path.lineTo(0, size.height - 150); // Baja hasta casi el final
    path.quadraticBezierTo(
      size.width / 2, size.height, // Punto de control para la curva
      size.width, size.height - 150, // Punto final de la curva
    );
    path.lineTo(size.width, 0); // Sube al tope derecho
    path.close(); // Cierra el camino
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
