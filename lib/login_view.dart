import 'dart:convert';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  // Simulación de respuesta JSON con las credenciales válidas
  final String validUserJson = '{"usuario": "admin", "password": "12345"}';
  late Map<String, dynamic> validUser;

  @override
  void initState() {
    super.initState();
    validUser = json.decode(validUserJson);
  }

  void _login() {
    if (_usuarioController.text == validUser['usuario'] &&
        _passwordController.text == validUser['password']) {
      setState(() {
        _errorMessage = '';
      });
      Navigator.pushReplacementNamed(context, '/mainScreen');
    } else {
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Stack(
        children: [
          // Imagen de fondo que cubre toda la pantalla
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondologin.png.png'
                    ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido de la pantalla (cajas de texto con íconos)
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Iniciar Sesión'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: Text('Olvidé mi contraseña'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
