import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModuloUsuarios extends StatefulWidget {
  @override
  _ModuloUsuariosState createState() => _ModuloUsuariosState();
}

class _ModuloUsuariosState extends State<ModuloUsuarios> {
  final _formKey = GlobalKey<FormState>();

  final _controllers = {
    "nombre": TextEditingController(),
    "telefono": TextEditingController(),
    "email": TextEditingController(),
    "grupo": TextEditingController(),
    "rol": TextEditingController(),
    "direccion": TextEditingController(),
    "password": TextEditingController(),
  };

  // Validaciones
  String? _validateCampo(String? value, String mensaje, {int? maxLength, bool? isEmail, bool? isNumeric}) {
    if (value == null || value.isEmpty) return mensaje;
    if (maxLength != null && value.length > maxLength) return 'Máximo $maxLength caracteres';
    if (isEmail == true && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Email no válido';
    if (isNumeric == true && !RegExp(r'^\d+$').hasMatch(value)) return 'Ingresa solo números';
    return null;
  }

  // Métodos CRUDxa
  Future<void> _insertUser() async => _sendData("insertar");
  Future<void> _updateUser() async => _sendData("actualizar");
  Future<void> _deleteUser() async => _sendData("eliminar");

  Future<void> _sendData(String action) async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://192.168.0.7:3001/api/usuarios/$action');

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(_controllers.map((key, value) => MapEntry(key, value.text))),
        );

        final responseData = json.decode(response.body);
        String message = responseData["message"] ?? "Error inesperado";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: response.statusCode == 201 ? Colors.green : Colors.red),
        );

        if (response.statusCode == 201) _clearFields();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _clearFields() {
    _controllers.forEach((key, controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset('assets/fondologin.png', fit: BoxFit.cover),
          ),
          // Contenido centrado
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Registro de Usuario', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField("Nombre", "Ingrese el nombre", _controllers["nombre"]!, maxLength: 50),
                          _buildTextField("Teléfono", "Ingrese teléfono", _controllers["telefono"]!, maxLength: 10, isNumeric: true),
                          _buildTextField("Email", "Ingrese correo", _controllers["email"]!, isEmail: true),
                          _buildTextField("Grupo", "Ingrese grupo", _controllers["grupo"]!, maxLength: 10),
                          _buildTextField("Rol", "Ingrese rol", _controllers["rol"]!, maxLength: 10),
                          _buildTextField("Dirección", "Ingrese dirección", _controllers["direccion"]!, maxLength: 70),
                          _buildTextField("Contraseña", "Ingrese contraseña", _controllers["password"]!, obscureText: true),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildButton("Insertar", Colors.green, _insertUser),
                              _buildButton("Actualizar", Colors.blue, _updateUser),
                              _buildButton("Eliminar", Colors.red, _deleteUser),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String errorText, TextEditingController controller, {bool obscureText = false, int? maxLength, bool? isEmail, bool? isNumeric}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
        ),
        obscureText: obscureText,
        validator: (value) => _validateCampo(value, errorText, maxLength: maxLength, isEmail: isEmail, isNumeric: isNumeric),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color, padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
