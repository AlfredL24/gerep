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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El nombre no puede estar vacío';
                    }
                    return null;
                  },
                  onChanged: (value) => nombre = value,
                ),
                TextFormField(
                  initialValue: telefono == 0 ? "" : telefono.toString(),
                  decoration: InputDecoration(labelText: "Teléfono"),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Campo obligatorio';
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Debe contener exactamente 10 dígitos';
                    }
                    return null;
                  },
                  onChanged: (value) => telefono = int.tryParse(value) ?? 0,
                ),
                TextFormField(
                  initialValue: email,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Campo obligatorio';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Correo no válido';
                    }
                    return null;
                  },
                  onChanged: (value) => email = value,
                ),
                TextFormField(
                  initialValue: grupo,
                  decoration: InputDecoration(labelText: "Grupo (ej. 3A)"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Campo obligatorio';
                    if (!RegExp(r'^[1-9][A-Za-z]$').hasMatch(value)) {
                      return 'Formato inválido. Ej: 3A';
                    }
                    return null;
                  },
                  onChanged: (value) => grupo = value.toUpperCase(),
                ),
                TextFormField(
                  initialValue: direccion,
                  decoration: InputDecoration(labelText: "Dirección"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'La dirección no puede estar vacía';
                    }
                    return null;
                  },
                  onChanged: (value) => direccion = value,
                ),
                TextFormField(
                  initialValue: contrasena,
                  decoration: InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo obligatorio';
                    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$').hasMatch(value)) {
                      return 'Debe tener 8 caracteres, una mayúscula, una minúscula, un número y un símbolo';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Selecciona un rol';
                    return null;
                  },
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit({
                        "nombre": nombre,
                        "telefono": telefono,
                        "email": email,
                        "rol": rolSeleccionado,
                        "direccion": direccion,
                        "contrasena": contrasena,
                        "foto": foto,
                        "grupo": grupo,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Corrige los errores del formulario.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text("Guardar"),
                ),
              ],
            )
        ),
      ),
    );
  }
}
