import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Asegura que el Stack ocupe toda la pantalla
        children: [
          // Imagen de fondo que cubre toda la pantalla
          Image.asset(
            'assets/bienvenido.png', // Asegúrate de declarar este asset en pubspec.yaml
            fit: BoxFit.cover,
          ),
          // Botón centrado pero desplazado 2 cm hacia abajo (aprox. 75 píxeles)
          Center(
            child: Transform.translate(
              offset: Offset(0, 75), // Aproximadamente 2 cm hacia abajo
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
