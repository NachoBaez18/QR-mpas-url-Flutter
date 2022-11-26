import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_app/models/scan_model.dart';
export 'package:qr_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // path de donde almacenaremos la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'ScansDB.db');

    //crear DB

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE Scans(
                  id INTEGER PRIMARY KEY,
                  tipo TEXT,
                  valor TEXT
                )
           ''');
    });
  }

  Future<int> nuevScanRaw(ScanModel nuevoScan) async {
    final db = await database;

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final res = await db.rawInsert('''
        INSERT INTO Scans( id, tipo, valor)
          VALUES($id, '$tipo','$valor')
''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>?> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''

    SELECT * FROM Scans WHERE tipo = '$tipo'

    ''');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScans(ScanModel nuevoScans) async {
    final db = await database;

    final res = await db.update('Scans', nuevoScans.toJson(),
        where: 'id = ?', whereArgs: [nuevoScans.id]);

    return res;
  }

  
  Future<int> deleteScans(int id) async {
    final db = await database;

    final res = await db.delete('Scans',
        where: 'id = ?', whereArgs: [id]);

    return res;
  }
    Future<int> deleteAllScans() async {
    final db = await database;

    final res = await db.delete('Scans');

    return res;
  }
}
