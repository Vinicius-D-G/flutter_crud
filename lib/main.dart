import 'package:flutter/material.dart';
import 'package:flutter_crud/telas/telas_planeta.dart';

import 'controles/controle_planeta.dart';
import 'modelos/planeta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'app - planetas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  List<Planeta> _planetas = [];

  @override
  void initState() {
    super.initState();
    _atualizarplanetas();
  }

  Future<void> _atualizarplanetas() async {
    final resultado = await _controlePlaneta.lerPlanetas();
    setState(() {
      _planetas = resultado;
    });
  }

  void _inserirPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TelaPlaneta(
              planeta: Planeta.vazio(),
              IsIncluir: true,
              onFinalizado: () {
                _atualizarplanetas();
              },
            ),
      ),
    );
  }

  void _alterarPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TelaPlaneta(
              IsIncluir: false,
              planeta: planeta,
              onFinalizado: () {
                _atualizarplanetas();
              },
            ),
      ),
    );
  }

  void _excluirPlaneta(int id) async {
    await _controlePlaneta.excluirPlaneta(id);
    _atualizarplanetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _planetas.length,
          itemBuilder: (context, index) {
            final planeta = _planetas[index];
            return ListTile(
              title: Text(planeta.nome),
              subtitle: Text(planeta.apelido ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _excluirPlaneta(planeta.id!),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _alterarPlaneta(context, planeta),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _inserirPlaneta(context, Planeta.vazio()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
