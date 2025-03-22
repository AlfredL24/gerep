import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  void _simulateProgress() {
    // Simula una barra de progreso que se actualiza cada 100 ms
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progressValue += 0.05;
        if (_progressValue >= 2.0) {
          timer.cancel();
          // Al finalizar el progreso, navega a la pantalla de bienvenida
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeView()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo que cubre toda la pantall  a
          Positioned.fill(
            child: Image.asset(
              'assets/splas_screen.png',

              fit: BoxFit.cover,
            ),
          ),

          // Barra de progreso centrada
          Center(
            child: CircularProgressIndicator(
              value: _progressValue,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}