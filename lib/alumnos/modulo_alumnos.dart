import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gerep/alumnos/modulo_alumnos_crear.dart';
import 'package:gerep/alumnos/modulo_alumnos_actualizar.dart';

class Alumno {
  final int id;
  final String nombre;
  final int edad;
  final String foto;
  final String enfermedades;
  final String tipoSangre;
  final String alergias;
  final String cuidadosEspeciales;

  Alumno(
      {required this.id,
      required this.nombre,
      required this.edad,
      required this.foto,
      required this.enfermedades,
      required this.tipoSangre,
      required this.alergias,
      required this.cuidadosEspeciales});

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      id: json['id'],
      nombre: json['nombre'],
      edad: json['edad'],
      foto: json['foto'],
      enfermedades: json['enfermedades'] ?? "",
      tipoSangre: json['tipoSangre'] ?? "",
      alergias: json['alergias'] ?? "",
      cuidadosEspeciales: json['cuidadosEspeciales'] ?? "",
    );
  }
}

class ModuloAlumnos extends StatefulWidget {
  @override
  _ModuloAlumnosState createState() => _ModuloAlumnosState();
}

class _ModuloAlumnosState extends State<ModuloAlumnos> {
  final String apiUrl = "http://89.117.149.126/gerep/api/alumnos";

  Future<List<Alumno>> getAlumnos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Alumno.fromJson(data)).toList();
    } else {
      throw Exception('Error al cargar alumnos');
    }
  }

  Future<void> deleteAlumno(int id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));
    if (response.statusCode == 200) {
      setState(() {});
    } else {
      throw Exception('Error al eliminar alumno');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Alumnos")),
      body: FutureBuilder<List<Alumno>>(
        future: getAlumnos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final alumnos = snapshot.data!;
            return ListView.builder(
              itemCount: alumnos.length,
              itemBuilder: (context, index) {
                final alumno = alumnos[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(alumno.foto),
                    ),
                    title: Text(alumno.nombre),
                    subtitle: Text("Edad: ${alumno.edad}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ModuloAlumnosActualizar(alumno: alumno),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteAlumno(alumno.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModuloAlumnosCrear()),
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
