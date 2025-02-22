import 'package:flutter/material.dart';

class ResetCredentialsView extends StatefulWidget {
  @override
  _ResetCredentialsViewState createState() => _ResetCredentialsViewState();
}

class _ResetCredentialsViewState extends State<ResetCredentialsView> {
  final TextEditingController _newUsuarioController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String _message = '';

  void _updateCredentials() {
    // Aquí se simula la actualización en la base de datos.
    // En un caso real, deberás implementar la lógica de actualización.
    setState(() {
      _message = 'Credenciales actualizadas correctamente';
    });
    Navigator.pushReplacementNamed(context, '/mainScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modificar Credenciales')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newUsuarioController,
              decoration: InputDecoration(labelText: 'Nuevo Usuario'),
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'Nueva Contraseña'),
              obscureText: true,
            ),
            if (_message.isNotEmpty)
              Text(_message, style: TextStyle(color: Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateCredentials,
              child: Text('Modificar'),
            ),
          ],
        ),
      ),
    );
  }
}
