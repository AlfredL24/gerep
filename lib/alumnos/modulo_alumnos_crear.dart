import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'modulo_alumnos_form.dart';

class ModuloAlumnosCrear extends StatelessWidget {
  final String apiUrl = "http://89.117.149.126/gerep/api/alumnos";

  Future<void> createAlumno(
      Map<String, dynamic> alumnoData, BuildContext context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(alumnoData),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      throw Exception('Error al crear alumno');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlumnoForm(
      onSubmit: (alumnoData) => createAlumno(alumnoData, context),
      isEditing: false,
    );
  }
}
