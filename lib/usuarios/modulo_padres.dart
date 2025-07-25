import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gerep/usuarios/modulo_usuario_crear.dart';
import 'modulo_usuario_actualizar.dart';
import 'modulo_usuarios.dart';
import 'modulo_usuario_form.dart';

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

  Usuario({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.email,
    required this.grupo,
    required this.direccion,
    required this.contrasena,
    required this.rol,
    required this.foto,
  });

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

class ModuloPadres extends StatefulWidget {
  @override
  _ModuloPadresState createState() => _ModuloPadresState();
}

class _ModuloPadresState extends State<ModuloPadres> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Padres de Familia")),
      body: FutureBuilder<List<Usuario>>(
        future: getUsuario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final usuarios = snapshot.data!
                .where((usuario) => usuario.rol.toLowerCase() == 'padre')
                .toList(); //Lista de usuarios filtrada por rol padre

            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usuario.foto),
                    ),
                    title: Text(
                      usuario.nombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text("Rol: ${usuario.rol}"),
                        Text("Tel: ${usuario.telefono}"),
                        Text("Email: ${usuario.email}"),
                        Text("Dirección: ${usuario.direccion}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
