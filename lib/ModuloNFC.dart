import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class ModuloNFC extends StatefulWidget {
  @override
  _ModuloNFCState createState() => _ModuloNFCState();
}

class _ModuloNFCState extends State<ModuloNFC> {
  String imagePath = 'assets/Colocar_NFC.png';
  final String apiUrl = "http://89.117.149.126/gerep/api/alumnos/tag";
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    startScanning();
  }

  void startScanning() {
    setState(() {
      imagePath = 'assets/Colocar_NFC.png';
    });

    Future.delayed(Duration(milliseconds: 500), () {
      leerNFC();
    });
  }

  Future<void> leerNFC() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      print("NFC no disponible en este dispositivo");
      return;
    }

    print("🟢 Iniciando sesión NFC...");

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        print("Tag detectado: ${tag.data}");

        var tagUid;
        var techType;

        if (tag.data.containsKey("isodep")) {
          tagUid = tag.data["isodep"]["identifier"];
          techType = "ISO-DEP";
        } else if (tag.data.containsKey("nfca")) {
          tagUid = tag.data["nfca"]["identifier"];
          techType = "NFC-A";
        } else {
          techType = "Desconocido";
        }

        print("Tipo de NFC: $techType");

        if (tagUid != null) {
          String uidHex = tagUid.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');
          print("UID del tag en HEX: $uidHex");

          bool alumnoExiste = await validarAlumno(uidHex);
          if (alumnoExiste) {
            print("Alumno registrado");
            setState(() {
              imagePath = 'assets/NFC_Válido.png';
            });
            await audioPlayer.play(AssetSource('sounds/Beep.mp3'));
          } else {
            print("Alumno no encontrado");
            setState(() {
              imagePath = 'assets/NFC_Invalido.png';
            });
            await audioPlayer.play(AssetSource('sounds/Beep_Invalido.mp3'));
          }

          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              imagePath = 'assets/Colocar_NFC.png';
            });
            startScanning(); //Reinicia el escaneo NFC
          });
        } else {
          print("No se pudo obtener el UID del tag");
        }

        NfcManager.instance.stopSession();
      },
      onError: (error) async {
        print("Error en la sesión NFC: $error");
        NfcManager.instance.stopSession();
      },
    );
  }

  Future<bool> validarAlumno(String tagUid) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$tagUid'));
      print("Respuesta de la API: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Datos decodificados: $data");

        if (data != null && data['tagUid'] == tagUid) {
          return true;
        }
      }
    } catch (e) {
      print("Error de conexión: $e");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
