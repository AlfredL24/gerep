import 'package:flutter/material.dart';

class MainScreenView extends StatelessWidget {
  void _irModuloUsuarios(BuildContext context) {
    Navigator.pushNamed(context, '/moduloUsuarios');
  }

  void _irModuloAlumnos(BuildContext context) {
    Navigator.pushNamed(context, '/moduloAlumnos');
  }

  void _irModuloDocentes(BuildContext context) {
    Navigator.pushNamed(context, '/moduloDocentes');
  }

  void _irModuloPadres(BuildContext context) {
    Navigator.pushNamed(context, '/moduloPadres');
  }

  void _irModuloReportes(BuildContext context) {
    Navigator.pushNamed(context, '/moduloReportes');
  }

  void _irModuloSalones(BuildContext context) {
    Navigator.pushNamed(context, '/moduloSalones');
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
            child: SingleChildScrollView(
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Icon(Icons.person, size: 50),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          const Text('Usuarios',
                              style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _irModuloAlumnos(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blueGrey[100],
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Icon(Icons.face_sharp, size: 50),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text('Alumnos', style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _irModuloDocentes(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blueGrey[100],
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Icon(Icons.school_rounded, size: 50),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          const Text('Docentes',
                              style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _irModuloPadres(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blueGrey[100],
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Icon(Icons.family_restroom, size: 50),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          const Text('Padres', style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _irModuloReportes(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blueGrey[100],
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Icon(Icons.edit_document, size: 50),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          const Text('Reportes',
                              style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _irModuloSalones(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blueGrey[100],
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Icon(Icons.home_filled, size: 50),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          const Text('Salones', style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
