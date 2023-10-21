// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:virus_total_multi/gen/assets.gen.dart';
import 'package:virus_total_multi/screens/analysis_screen.dart';

// fe28af36e31229d1d30659acad341b4af8b8ef2cbb0bdaf7fc627009cb4f67ea
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.shield.lottie(),
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Esta herramienta le ayudará a inspeccionar un archivo en busqueda de virus',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                  onPressed: () async => await pickFile(context), icon: const Icon(Symbols.file_upload), label: const Text('Analizar archivo'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AnalysisScreen(file: file),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('No se seleccionó un archivo válido'),
        action: SnackBarAction(label: 'Aceptar', onPressed: () {}),
      ));
    }
  }
}
