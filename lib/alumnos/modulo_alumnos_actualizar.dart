import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'modulo_alumnos_form.dart';
import 'modulo_alumnos.dart';

class ModuloAlumnosActualizar extends StatelessWidget {
  final Alumno alumno;
  final String apiUrl = "http://89.117.149.126/gerep/api/alumnos";

  ModuloAlumnosActualizar({required this.alumno});

  Future<void> updateAlumno(
      Map<String, dynamic> alumnoData, BuildContext context) async {
    final response = await http.put(
      Uri.parse("$apiUrl/${alumno.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(alumnoData),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      throw Exception('Error al actualizar alumno');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlumnoForm(
      onSubmit: (alumnoData) => updateAlumno(alumnoData, context),
      isEditing: true,
      alumno: alumno,
    );
  }
}
