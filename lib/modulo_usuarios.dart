import 'package:flutter/material.dart';
import 'main_screen_view.dart';

class ModuloUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo Usuarios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Módulo Usuarios'),
            // Aquí puedes ir agregando los módulos que desees.
          ],
        ),
      ),
    );
  }
}
