import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:virus_total_multi/data/services.dart';
import 'package:virus_total_multi/gen/assets.gen.dart';
import 'package:virus_total_multi/models/analysis_response.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  late Stream<Map<String, dynamic>?> _future;
  @override
  void initState() {
    _future = Services.sendFile(file: widget.file).asStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: _future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const ScanPlaceholder();
              }
              if (snapshot.data == null || snapshot.data!.containsKey('error')) {
                return ErrorPlaceholder(errorMessage: snapshot.data!['error']);
              }

              final AnalysisResponse analysis = snapshot.data!['ok'];

              return ScanCompleteReport(analysis: analysis);
            }),
      ),
    );
  }
}

class ScanCompleteReport extends StatelessWidget {
  const ScanCompleteReport({
    super.key,
    required this.analysis,
  });

  final AnalysisResponse analysis;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 350),
            child: analysis.data.attributes.stats.malicious > 0 ? Assets.hacker.lottie() : Assets.clean.lottie(),
          ),
          const SizedBox(height: 20),
          Text(
            analysis.data.attributes.stats.malicious > 0 ? '¡OH NOO! elimina eso rápido' : '¡No se encontraron amenazas!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 10),
          Expanded(child: ScanResults(analysis: analysis)),
          FilledButton.icon(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Symbols.arrow_back_ios), label: const Text('Regresar'))
        ],
      ),
    );
  }
}

class ScanResults extends StatelessWidget {
  const ScanResults({
    super.key,
    required this.analysis,
  });

  final AnalysisResponse analysis;

  @override
  Widget build(BuildContext context) {
    final results = analysis.data.attributes.results.values.toList();
    return Column(
      children: [
        Text('Estado: ${analysis.data.attributes.status}'),
        Text('No soportados: ${analysis.data.attributes.stats.typeUnsupported}'),
        Text('Fallados: ${analysis.data.attributes.stats.failure}'),
        Text('Malicioso: ${analysis.data.attributes.stats.malicious}'),
        Text('Sospechosos: ${analysis.data.attributes.stats.suspicious}'),
        const SizedBox(height: 10),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) => Card(
                  child: ListTile(
                leading: const CircleAvatar(child: Icon(Symbols.bug_report)),
                title: Text(results[index].engineName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categoría: ${results[index].category.name}'),
                    Text('Método: ${results[index].method.name}'),
                  ],
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class ScanPlaceholder extends StatelessWidget {
  const ScanPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(constraints: const BoxConstraints(maxHeight: 350), child: Assets.scan.lottie()),
          const SizedBox(height: 20),
          const Text(
            'Escaneando archivo, por favor espere...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 40),
          FilledButton.icon(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Symbols.close), label: const Text('Cancelar'))
        ],
      ),
    );
  }
}

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 350,
              ),
              child: Assets.error.lottie(repeat: false)),
          const SizedBox(height: 20),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 40),
          FilledButton.icon(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Symbols.arrow_back_ios), label: const Text('Regresar'))
        ],
      ),
    );
  }
}
