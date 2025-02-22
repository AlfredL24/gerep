import 'package:flutter/material.dart';

class MainScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Módulo 1'),
            SizedBox(height: 10),
            Text('Módulo 2'),
            SizedBox(height: 10),
            Text('Módulo 3'),
            // Aquí puedes ir agregando los módulos que desees.
          ],
        ),
      ),
    );
  }
}
