import 'dart:io';
import 'package:dashboard_app/models/histry_data.dart';
import 'package:dashboard_app/models/icon_data.dart';
import 'package:dashboard_app/models/income_data.dart';
import 'package:dashboard_app/models/income_histry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DataBase {
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
    String path = join(documentsDirectory.path, "tbl_icon_data.db");
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("asset/", "tbl_icon_data.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes);
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'tbl_icon_data.db');
    _database = await openDatabase(databasePath);
    return _database;
  }

////////////////////////////////////////////////////////get expense data////////////////////////////////////
  Future<List<IconDetail>> getData() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("icon_data", columns: [
      "id",
      "category_name",
      "category_symbole",
      "symbole_color",
      "category_class"
    ] );

    /*
        String whereString = '${DatabaseHelper.columnId} = ?';
    int rowId = 1;
    List<dynamic> whereArguments = [rowId];
    List<Map> result = await db.query(
        DatabaseHelper.table,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

     */

    return List.generate(result.length, (index) {
      return IconDetail(
          id: result[index]["id"],
          category_name: result[index]["category_name"],
          category_symbole: result[index]["category_symbole"],
          symbole_color: result[index]["symbole_color"],
          category_class: result[index]["category_class"]);
    });
  }
  Future<List<IconDetail>> getDataByType(String class_name) async {
    print("==============================================${class_name}");
    final db = await database;
    String class_cheak = "category_class= ?";
    List<Map<String, dynamic>> result = await db.query("icon_data", columns: [
      "id",
      "category_name",
      "category_symbole",
      "symbole_color",
      "category_class"
    ],where: class_cheak,
    whereArgs:[class_name] );

    /*
        String whereString = '${DatabaseHelper.columnId} = ?';
    int rowId = 1;
    List<dynamic> whereArguments = [rowId];
    List<Map> result = await db.query(
        DatabaseHelper.table,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

     */

    return List.generate(result.length, (index) {
      return IconDetail(
          id: result[index]["id"],
          category_name: result[index]["category_name"],
          category_symbole: result[index]["category_symbole"],
          symbole_color: result[index]["symbole_color"],
          category_class: result[index]["category_class"]);
    });
  }





///////////////////////////////////////////////////////////insrert expence data/////////////////////////////////////
  insertData(String category_name, String category_symbole,
      String symbole_color, String category_class) async {
    final db = await database;
    await db.insert("icon_data", {
      "category_name": category_name,
      "category_symbole": category_symbole,
      "symbole_color": symbole_color,
      "category_class": category_class
    });
  }


///////////////////////////////////////////////////////delete expence data/////////////////////////////////////////////////
  Future<int> deleteData(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM icon_data WHERE id = $id');
    return result;
  }


//////////////////////////////////////////////////////////////update expense data//////////////////////////////////////////////
  Future<int> updateData(String category_name, String category_symbole,
      String symbole_color, int id) async {
    var db = await this.database;
    // var result = await db.rawUpdate(dbTable, data.toMap(), where: '$colId = ?', whereArgs: [data.id]);\
    var result = await db.rawUpdate(
        '''UPDATE icon_data SET  category_name = ?, category_symbole = ? ,symbole_color = ? WHERE id = ?''',
        [category_name, category_symbole, symbole_color, id]);
    return result;
  }

//////////////////////////////////////////////////////////////////////get expence histry data///////////////////////////////////////////////
  Future<List<HistryDetail>> getHistrtyData() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("histry_data", columns: [
      "id",
      "category_name",
      "category_symbole",
      "time",
      "date",
      "price",
      "add_day",
      "add_month",
      "add_year",
      "full_date",
      "icon_color",
      "category_class",
      "main_id"
    ]);

    return List.generate(result.length, (index) {
      return HistryDetail(
          id: result[index]["id"],
          category_name: result[index]["category_name"],
          category_symbole: result[index]["category_symbole"],
          time: result[index]["time"],
          date: result[index]["date"],
          price: result[index]["price"],
          add_day: result[index]["add_day"],
          add_month: result[index]["add_month"],
          add_year: result[index]["add_year"],
          full_date: result[index]["full_date"],
          icon_color: result[index]["icon_color"],
          category_class: result[index]["category_class"],
      main_id:result[index]["main_id"]);
    });
  }


////////////////////////////////////////////////////////////////////insert expence histry data/////////////////////////////////////////////////
  insertHistryData(
      String category_name,
      String category_symbole,
      String time,
      String date,
      String price,
      String add_day,
      String add_month,
      String add_year,
      String full_date,
      String icon_color,
      String category_class,
      int main_id) async {




    final db = await database;
    int i=await db.insert("histry_data", {
      "category_name": category_name,
      "category_symbole": category_symbole,
      "time": time,
      "date": date,
      "price": price,
      "add_day": add_day,
      "add_month": add_month,
      "add_year": add_year,
      "full_date": full_date,
      "icon_color": icon_color,
      "category_class": category_class,
      "main_id":main_id,
    });

    print("i===$i");
  }

  ///////////////////////////////////////////////////////////delete histry data/////////////////////////////////////////////////////////
  Future<int> deleteHistryData(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM histry_data WHERE id = $id');
    return result;
  }



  ///////////////////////////////////////////////////////////update expence histry data/////////////////////////////////////////////////
  Future<int> updateHistryData(String price, String category_name,String category_symbole,String icon_color,String category_class,int id) async {
    var db = await this.database;
    // var result = await db.rawUpdate(dbTable, data.toMap(), where: '$colId = ?', whereArgs: [data.id]);\
    // var result = await db.rawUpdate('''UPDATE histry_data SET  price = ?, category_name = ?, category_symbole = ? WHERE id = ?''', [price,category_name,category_symbole,id]);


    Map<String, Object?> value={

      "price": price,
      "category_name": category_name,
      "category_symbole": category_symbole,
      "icon_color":icon_color,
      "category_class":category_class

    };

    print("data-====$price===$category_name==$category_symbole");


    var result  =await db.update('histry_data', value,where: "id = ?",whereArgs: [id]);

    print("re====$result=====${id}");
    return result;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<double?> calculateTotal() async {
    var db = await this.database;
    var result =
        await db.rawQuery("SELECT SUM(price) as Total FROM histry_data;");
    print("result is -4---------------${result.length}");

    if (result.length > 0) {
      Map<String, dynamic> json = result[0];

      var total = json['Total'];

      if (total != null) {
        return total;
        //return  int.parse( result[0]['Total'].toString());
      }
      print("resul1-------------${result}");
      return 0;
    }
    return 0;
  }

  //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////incomePriceTotal///////////////////////////
  Future<double?> calculateIncomeTotal() async {
    var db = await this.database;
    var result =
    await db.rawQuery("SELECT SUM(price) as Total FROM histry_data WHERE category_class='income'");
    print("result is -4---------------${result.length}");

    if (result.length > 0) {
      Map<String, dynamic> json = result[0];

      var total = json['Total'];

      if (total != null) {
        return total;
        //return  int.parse( result[0]['Total'].toString());
      }
      print("resul1-------------${result}");
      return 0;
    }
    return 0;
  }
  ////////////////////////////////////////////////////////ExpencePricetotal//////////////////////////////
  Future<double?> calculateIExpenceTotal() async {
    var db = await this.database;
    var result =
    await db.rawQuery("SELECT SUM(price) as Total FROM histry_data WHERE category_class='expence'");
    print("result is -4---------------${result.length}");

    if (result.length > 0) {
      Map<String, dynamic> json = result[0];

      var total = json['Total'];

      if (total != null) {
        return total;
        //return  int.parse( result[0]['Total'].toString());
      }
      print("resul1-------------${result}");
      return 0;
    }
    return 0;
  }

  ///////////////////////////////////////////////histrydetailegroupprice///////////////////////////////////
// SELECT main_id, SUM(price) FROM histry_data GROUP BY main_id;
  Future<double?> calculateGroupTotal() async {
    var db = await this.database;
    var result =
    await db.rawQuery("SELECT main_id, SUM(price) FROM histry_data GROUP BY main_id;");
    print("result is -4---------------${result.length}");

    if (result.length > 0) {
      Map<String, dynamic> json = result[0];

      var total = json['Total'];

      if (total != null) {
        return total;
        //return  int.parse( result[0]['Total'].toString());
      }
      print("resul1-------------${result}");
      return 0;
    }
    return 0;
  }

  ///////////////////////////////////////////////////////
  Future<List<HistryDetail>?> calculateHistryGroup() async {
    var db = await this.database;
    List<Map<String, dynamic>> result =
    await db.rawQuery(" SELECT main_id,category_name,category_class,category_symbole,icon_color,id,time,date,add_day,add_month,add_year,full_date, SUM(price) FROM histry_data GROUP BY main_id;",
    );

    print("result is Histry group ---------------${result.length}");

    if (result.length > 0) {
      Map<String, dynamic> json = result[0];

      print("resul1-------------${result}");
      return  List.generate(result.length, (index) {
        return HistryDetail(
            id: result[index]["id"],
            category_name: result[index]["category_name"],
            category_symbole: result[index]["category_symbole"],
            time: result[index]["time"],
            date: result[index]["date"],
            price: result[index]["SUM(price)"].toString(),
            add_day: result[index]["add_day"],
            add_month: result[index]["add_month"],
            add_year: result[index]["add_year"],
            full_date: result[index]["full_date"],
            icon_color: result[index]["icon_color"],
            category_class: result[index]["category_class"],
            main_id:result[index]["main_id"]);
      });
    }
  }

}
