import 'package:flutter/material.dart';
import 'package:gerep/login_view.dart';
import 'login_view.dart';

class ResetCredentialsView extends StatefulWidget {
  @override
  _ResetCredentialsViewState createState() => _ResetCredentialsViewState();
}

class _ResetCredentialsViewState extends State<ResetCredentialsView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _message = '';

  void _updateCredentials() {
    // Aquí se simula la actualización en la base de datos.
    // En un caso real, deberás implementar la lógica de actualización.
    setState(() {
      String newPassword = _newPasswordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (newPassword.length < 5) {
        _message = 'La contraseña debe tener al menos 5 caracteres';
        return;
      }
      if (newPassword != confirmPassword) {
        _message = 'Las contraseñas no coinciden';
        return;
      }

      _message = 'Contraseña actualizada correctamente';
    });
    //Navigator.pushReplacementNamed(context, '/mainScreen');
  }

  void _regresarLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cambiar contraseña')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/logo_gerep.png',
              height: 100,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                  labelText: 'Nueva contraseña', border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  border: OutlineInputBorder()),
              obscureText: true,
            ),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.contains('correctamente')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateCredentials,
              child: Text('Cambiar contraseña'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _regresarLogin,
              child: Text('Regresar al inicio de sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
