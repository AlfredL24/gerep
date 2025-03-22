import 'package:flutter/material.dart';
import 'modulo_usuarios.dart';

class UsuarioForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isEditing;
  final Usuario? usuario;

  UsuarioForm({required this.onSubmit, required this.isEditing, this.usuario});

  @override
  _UsuarioFormState createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  String nombre = "";
  int telefono = 0;
  String email  = "";
  String grupo = "";
  String direccion = "";
  String contrasena = "";
  String foto = "";
  String? rolSeleccionado= "Profesor";

  // Lista de roles disponibles
  final List<String> roles = ["Director", "Profesor", "Padre de Familia"];


  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.usuario != null) {
      nombre = widget.usuario!.nombre;
      telefono = widget.usuario!.telefono as int;
      email = widget.usuario!.email;
      grupo = widget.usuario!.grupo;
      direccion = widget.usuario!.direccion;
      contrasena = widget.usuario!.contrasena;
      foto = widget.usuario!.foto;
      rolSeleccionado = widget.usuario!.grupo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isEditing ? "Editar Usuario" : "Agregar Usuario")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: nombre,
                decoration: InputDecoration(labelText: "Nombre"),
                onChanged: (value) => nombre = value,
              ),
              TextFormField(
                initialValue: telefono.toString(),
                decoration: InputDecoration(labelText: "Telefono"),
                keyboardType: TextInputType.number,
                onChanged: (value) => telefono = int.tryParse(value) ?? 0,
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                initialValue: grupo,
                decoration: InputDecoration(labelText: "Grupo"),
                onChanged: (value) => grupo = value,
              ),
              TextFormField(
                initialValue: direccion,
                decoration: InputDecoration(labelText: "Direccion"),
                onChanged: (value) => direccion = value,
              ),
              TextFormField(
                initialValue: contrasena,
                decoration: InputDecoration(labelText: "Contraseña"),
                onChanged: (value) => contrasena = value,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: (["Director", "Profesor", "Padre"].contains(rolSeleccionado))
                    ? rolSeleccionado
                    : "Profesor", // Valor predeterminado si no es válido
                decoration: InputDecoration(labelText: "Rol"),
                items: [
                  DropdownMenuItem(value: "Director", child: Text("Director")),
                  DropdownMenuItem(value: "Profesor", child: Text("Profesor")),
                  DropdownMenuItem(value: "Padre", child: Text("Padre de familia")),
                ],
                onChanged: (value) {
                  setState(() {
                    rolSeleccionado = value ?? "Profesor";
                  });
                },
              ),



              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit({
                      "nombre": nombre,
                      "telefono": telefono,
                      "email": email,
                      "rol": grupo,
                      "direccion": direccion,
                      "contrasena": contrasena,
                      "foto": foto,
                      "rol": rolSeleccionado,
                    });
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
