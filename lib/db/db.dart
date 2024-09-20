import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  String caminhoBanco = join(await getDatabasesPath(), 'bancodnv.db');

  return openDatabase(
    caminhoBanco,
    version: 2, // Atualize a versão do banco de dados
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE users('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'name TEXT, '
          'email TEXT, '
          'password TEXT) ' );});}