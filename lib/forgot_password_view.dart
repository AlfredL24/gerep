import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  String _errorEmail = '';

  bool _validateEmail(String email) {
    // Validación sencilla del formato de email
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  void _submitEmail() {
    if (_validateEmail(_emailController.text)) {
      setState(() {
        _errorEmail = '';
      });
      Navigator.pushNamed(context, '/resetCredentials');
    } else {
      setState(() {
        _errorEmail = 'Error de email';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Contraseña')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            if (_errorEmail.isNotEmpty)
              Text(_errorEmail, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitEmail,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
