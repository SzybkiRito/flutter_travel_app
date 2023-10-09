import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  static const _databaseName = 'travel_planning_app.db';
  static const _databaseVersion = 1;

  Future<int> _onDatabaseCreate(Database db, int version) async {
    try {
      String schema = await rootBundle.loadString("assets/database/schema.sql");
      List<String> queries = schema.split(";");
      for (String query in queries) {
        if (query.trim().isNotEmpty) {
          await db.execute(query);
        }
      }
    } catch (e) {
      throw Exception("Failed to create database: $e");
    }

    return 1;
  }

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onDatabaseCreate,
    );
  }

  Future<void> close(Database database) async {
    await database.close();
  }
}
