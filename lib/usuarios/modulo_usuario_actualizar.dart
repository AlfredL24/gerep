import 'package:flutter/material.dart';
import 'package:gerep/usuarios/modulo_usuarios.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'modulo_usuario_form.dart';

class ModuloUsuarioActualizar extends StatelessWidget {
  final Usuario usuario;
  final String apiUrl = "http://89.117.149.126/gerep/api/usuarios/profesor";

  ModuloUsuarioActualizar({required this.usuario});

  Future<void> updateUsuario(
      Map<String, dynamic> usuarioData, BuildContext context) async {
    final response = await http.put(
      Uri.parse("$apiUrl/${usuario.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(usuarioData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario actualizado correctamente"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } else {
      throw Exception('Error al actualizar alumno');
    }
  }

  @override
  Widget build(BuildContext context) {
    return UsuarioForm(
      onSubmit: (usuarioData) => updateUsuario(usuarioData, context),
      isEditing: true,
      usuario: usuario,
    );
  }
}
