import 'package:flutter/material.dart';
import 'main_screen_view.dart';

class ModuloAlumnos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo Alumnos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.face_sharp, size: 50),
            Text(
              'Módulo Alumnos',
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
