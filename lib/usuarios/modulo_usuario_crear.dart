import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'modulo_usuario_form.dart';

class ModuloUsuarioCrear extends StatelessWidget {
  final String baseUrl = "http://89.117.149.126/gerep/api/usuarios/registro/";

  Future<void> createUsuario(Map<String, dynamic> usuarioData, BuildContext context) async {
    try {
      // Determinar la URL según el rol seleccionado
      String? rol = usuarioData["rol"];
      if (rol == null || rol.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Por favor selecciona un rol."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Asignar la URL correcta según el rol
      String apiUrl = baseUrl + (rol == "Director"
          ? "director"
          : rol == "Profesor"
          ? "profesor"
          : "padre");

      // Enviar la solicitud HTTP POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(usuarioData),
      );

      print("Código de respuesta: ${response.statusCode}");
      print("Respuesta del servidor: ${response.body}");

      // el servidor devulve 200 conciderado como agregado
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuario agregado correctamente"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al crear usuario: ${response.body}"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Manejo de errores de conexión o fallos inesperados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error de conexión: $e"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return UsuarioForm(
      onSubmit: (usuarioData) => createUsuario(usuarioData, context),
      isEditing: false,
    );
  }
}
