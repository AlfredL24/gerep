import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'login_view.dart';
import 'main.dart';
import 'modulo_usuarios.dart';

class MainScreenView extends StatelessWidget {
  void _irModuloUsuarios(BuildContext context) {
    Navigator.pushNamed(context, '/moduloUsuarios');
  }

  void _regresarLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulos'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.asset('assets/logo_gerep.png', height: 100),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  onTap: () => _irModuloUsuarios(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.blueGrey[100],
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Icon(Icons.person, size: 50),
                        SizedBox(height: 30),
                        const Text('Usuarios', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey[100],
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.face_sharp, size: 50),
                      SizedBox(height: 30),
                      Text('Alumnos', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey[100],
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.school_rounded, size: 50),
                      SizedBox(height: 30),
                      const Text('Docentes', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey[100],
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.family_restroom, size: 50),
                      SizedBox(height: 30),
                      const Text('Padres', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey[100],
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.edit_document, size: 50),
                      SizedBox(height: 30),
                      const Text('Reportes', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey[100],
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.home_filled, size: 50),
                      SizedBox(height: 30),
                      const Text('Salones', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        onPressed: () => _regresarLogin(context),
        tooltip: 'Cerrar sesión',
        child: const Icon(
          Icons.logout_rounded,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}
