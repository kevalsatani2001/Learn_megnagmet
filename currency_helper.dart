import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../models/currency_data.dart';

class CurrencyDataBase {
  static var _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "currency.db");
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("asset/", "currency.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes);
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'currency.db');
    _database = await openDatabase(databasePath);
    return _database;
  }

  Future<List<CurrencyDetail>> getData() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("tbl_currency",
        columns: ["id", 'currencyname']);

    return List.generate(result.length, (index) {
      return CurrencyDetail(
        id: result[index]["id"],
        currencyname: result[index]["currencyname"],
      );
    });
  }

}
