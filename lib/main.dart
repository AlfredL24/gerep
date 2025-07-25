import 'package:flutter/material.dart';
import 'package:gerep/ModuloNFC.dart';
import 'package:gerep/usuarios/modulo_usuarios.dart';
import 'welcome_view.dart';
import 'login_view.dart';
import 'forgot_password_view.dart';
import 'reset_credentials_view.dart';
import 'main_screen_view.dart';
import 'splash_screen.dart';
import 'usuarios/modulo_usuarios.dart';
import 'alumnos/modulo_alumnos.dart';
import 'usuarios/modulo_padres.dart';
import 'usuarios/modulo_docentes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Preescolar',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeView(),
        '/login': (context) => LoginView(),
        '/forgotPassword': (context) => ForgotPasswordView(),
        '/resetCredentials': (context) => ResetCredentialsView(),
        '/mainScreen': (context) => MainScreenView(),
        '/moduloUsuarios': (context) => ModuloUsuario(),
        '/moduloAlumnos': (context) => ModuloAlumnos(),
        '/moduloScan': (context) => ModuloNFC(),
        '/moduloPadres': (context) => ModuloPadres(),
        '/moduloDocentes': (context) => ModuloDocentes(),
      },
    );
  }
}
