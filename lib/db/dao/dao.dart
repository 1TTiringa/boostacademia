import 'package:boostacademia/db/db.dart';
import 'package:boostacademia/model/users.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Future<int> insertUser(User user) async {
  Database db = await getDatabase();
  return db.insert('users', user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> findall() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query("Users");
  return dados;
}