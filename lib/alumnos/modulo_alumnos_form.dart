import 'package:flutter/material.dart';
import 'modulo_alumnos.dart';

class AlumnoForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isEditing;
  final Alumno? alumno;

  AlumnoForm({required this.onSubmit, required this.isEditing, this.alumno});

  @override
  _AlumnoFormState createState() => _AlumnoFormState();
}

class _AlumnoFormState extends State<AlumnoForm> {
  final _formKey = GlobalKey<FormState>();
  String nombre = "";
  int edad = 0;
  String foto = "";
  String enfermedades = "";
  String tipoSangre = "";
  String alergias = "";
  String cuidadosEspeciales = "";

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.alumno != null) {
      nombre = widget.alumno!.nombre;
      edad = widget.alumno!.edad;
      foto = widget.alumno!.foto;
      enfermedades = widget.alumno!.enfermedades;
      tipoSangre = widget.alumno!.tipoSangre;
      alergias = widget.alumno!.alergias;
      cuidadosEspeciales = widget.alumno!.cuidadosEspeciales;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isEditing ? "Editar Alumno" : "Agregar Alumno")),
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
                initialValue: edad.toString(),
                decoration: InputDecoration(labelText: "Edad"),
                keyboardType: TextInputType.number,
                onChanged: (value) => edad = int.tryParse(value) ?? 0,
              ),
              TextFormField(
                initialValue: foto,
                decoration: InputDecoration(labelText: "Foto (URL)"),
                onChanged: (value) => foto = value,
              ),
              TextFormField(
                initialValue: enfermedades,
                decoration: InputDecoration(labelText: "Enfermedades"),
                onChanged: (value) => enfermedades = value,
              ),
              TextFormField(
                initialValue: tipoSangre,
                decoration: InputDecoration(labelText: "Tipo de Sangre"),
                onChanged: (value) => tipoSangre = value,
              ),
              TextFormField(
                initialValue: alergias,
                decoration: InputDecoration(labelText: "Alergias"),
                onChanged: (value) => alergias = value,
              ),
              TextFormField(
                initialValue: cuidadosEspeciales,
                decoration: InputDecoration(labelText: "Cuidados Especiales"),
                onChanged: (value) => cuidadosEspeciales = value,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit({
                      "nombre": nombre,
                      "edad": edad,
                      "foto": foto,
                      "enfermedades": enfermedades,
                      "tipoSangre": tipoSangre,
                      "alergias": alergias,
                      "cuidadosEspeciales": cuidadosEspeciales,
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
