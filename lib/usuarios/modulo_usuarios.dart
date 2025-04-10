import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gerep/usuarios/modulo_usuario_crear.dart';
import 'modulo_usuario_actualizar.dart';

class Usuario {
  final int id;
  final String nombre;
  final int telefono;
  final String email;
  final String grupo;
  final String direccion;
  final String contrasena;
  final String foto;



  Usuario(
      {required this.id,
        required this.nombre,
        required this.telefono,
        required this.email,
        required this.grupo,
        required this.direccion,
        required this.contrasena,
        required this.foto});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      telefono: int.tryParse(json['telefono'].toString()) ?? 0,
      email: json['email']??"",
      grupo: json['grupo'] ?? "",
      direccion: json['direccion'] ?? "",
      contrasena: json['contrasena'] ?? "",
      foto: json['foto'] ?? "",

    );
  }
}

class ModuloUsuario extends StatefulWidget {
  @override
  _ModuloUsuarioState createState() => _ModuloUsuarioState();
}
class _ModuloUsuarioState extends State<ModuloUsuario> {
  final String apiUrl = "http://89.117.149.126/gerep/api/usuarios";

  Future<List<Usuario>> getUsuario() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Usuario.fromJson(data)).toList();
    } else {
      throw Exception('Error al cargar Usuario');
    }
  }

  Future<void> deleteUsuario(int id) async {
    try {
      final response = await http.delete(Uri.parse("$apiUrl/$id"));

      if (response.statusCode == 200 || response.body.isEmpty) {
        // Mostrar SnackBar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuario eliminado correctamente"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        //setState para actualizar la lista
        setState(() {});
      } else {
        // Mostrar error si la API devuelve otra respuesta
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al eliminar usuario: ${response.body}"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Manejar errores de conexión o fallos inesperados
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
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Usuarios")),
      body: FutureBuilder<List<Usuario>>(
        future: getUsuario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final usuarios = snapshot.data!;
            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usuario.foto),
                    ),
                    title: Text(usuario.nombre),
                    subtitle: Text("telefono: ${usuario.telefono}"),
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
                                    ModuloUsuarioActualizar(usuario: usuario),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUsuario(usuario.id),
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
            MaterialPageRoute(builder: (context) => ModuloUsuarioCrear()),
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
