import 'package:flutter/material.dart';

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
      _message = 'Contraseña actualizada correctamente';
    });
    Navigator.pushReplacementNamed(context, '/mainScreen');
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
              Text(_message, style: TextStyle(color: Colors.green)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateCredentials,
              child: Text('Cambiar contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
