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
  final String rol;
  final String foto;

  Usuario(
      {required this.id,
      required this.nombre,
      required this.telefono,
      required this.email,
      required this.grupo,
      required this.direccion,
      required this.contrasena,
      required this.rol,
      required this.foto});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      telefono: int.tryParse(json['telefono'].toString()) ?? 0,
      email: json['email'] ?? "",
      grupo: json['grupo'] ?? "",
      direccion: json['direccion'] ?? "",
      contrasena: json['contrasena'] ?? "",
      rol: json['rol'] ?? "",
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
    final response = await http.delete(Uri.parse("$apiUrl/$id"));

    if (response.statusCode == 200 || response.statusCode == 204) {
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
      throw Exception('Error al eliminar alumno');
    }
  }

  Future<void> confirmDelete(BuildContext context, int id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Seguro que deseas eliminar este usuario?"),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(), // Cerrar sin eliminar
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar diálogo
                try {
                  await deleteUsuario(id); // Intentar eliminar
                } catch (e) {
                  // Si hay error, mostrar mensaje en un SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error al eliminar el usuario"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Eliminar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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
                    subtitle: Text("Rol: ${usuario.rol}"),
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
                          onPressed: () => confirmDelete(context, usuario.id),
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
