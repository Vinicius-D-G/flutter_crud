import 'dart:async';

import 'package:flutter_crud/modelos/planeta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // Adiciona a importação para 'join'

class ControlePlaneta {
  static Database? _bd;

  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.bd');
    return _bd!;
  }

  Future<Database> _initBD(String LocalArquivo) async {
    final caminhoBD = await getDatabasesPath();
    final caminho = join(caminhoBD, LocalArquivo);
    return await openDatabase(caminho, version: 1, onCreate: _criarBD);
  }

  Future<void> _criarBD(Database bd, int versao) async {
    const sql = '''
    CREATE TABLE planetas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      tamanho REAL NOT NULL,
      distancia REAL NOT NULL,
      apelido TEXT)
    ''';
    await bd.execute(sql);
  }

  Future<List<Planeta>> lerPlanetas() async {
    final db = await bd;
    final resultado = await db.query('planetas');
    return resultado.map((map) => Planeta.fromMap(map)).toList();
  }

  Future<int> InserirPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.insert("planetas", planeta.toMap());
  }

  Future<int> excluirPlaneta(int id) async {
    final db = await bd;
    return await db.delete('planetas', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> alterarPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }
}
