import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/bienvenido.png',
            fit: BoxFit.cover,
          ),

          Center(
            child: Transform.translate(
              offset: Offset(0, 75),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[50], // Fondo azul
                  side: BorderSide(color: Colors.white, width: 2), // Borde blanco
                ),
                child: Text('Iniciar Sesión'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
