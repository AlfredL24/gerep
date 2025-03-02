import 'package:flutter/material.dart';
import 'package:gerep/modulo_usuarios.dart';
import 'welcome_view.dart';
import 'login_view.dart';
import 'forgot_password_view.dart';
import 'reset_credentials_view.dart';
import 'main_screen_view.dart';
import 'splash_screen.dart';
import 'modulo_usuarios.dart';

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
        '/moduloUsuarios': (context) => ModuloUsuarios(),
      },
    );
  }
}
