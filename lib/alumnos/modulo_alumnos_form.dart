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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('assets/logo_gerep.png', height: 100),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            initialValue: nombre,
                            decoration: InputDecoration(
                              labelText: "Nombre",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onChanged: (value) => nombre = value,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            initialValue: edad.toString(),
                            decoration: InputDecoration(
                              labelText: "Edad",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                edad = int.tryParse(value) ?? 0,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            initialValue: foto,
                            decoration: InputDecoration(
                              labelText: "Foto (URL)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onChanged: (value) => foto = value,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            initialValue: enfermedades,
                            decoration: InputDecoration(
                              labelText: "Enfermedades",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onChanged: (value) => enfermedades = value,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            initialValue: tipoSangre,
                            decoration: InputDecoration(
                              labelText: "Tipo de Sangre",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onChanged: (value) => tipoSangre = value,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            initialValue: alergias,
                            decoration: InputDecoration(
                              labelText: "Alergias",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onChanged: (value) => alergias = value,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            initialValue: cuidadosEspeciales,
                            decoration: InputDecoration(
                              labelText: "Cuidados Especiales",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onChanged: (value) => cuidadosEspeciales = value,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.green.shade300)),
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
                      child: Text(
                        "Guardar",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
