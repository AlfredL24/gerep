
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> insertarUsuario(Map<String, dynamic> usuario) async {
  // Colocar direcion donde se encuentra la api, direccion ip y puerto donde se corre el progreama
  final url = Uri.parse('http://192.168.0.8:3000/api/usuarios');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(usuario),
  );

  if (response.statusCode == 201) {
    print('Usuario insertado correctamente');
  } else {
    print('Error al insertar usuario: ${response.body}');
  }
}
