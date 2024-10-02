import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/data.dart';

class DbHelper {
  Database? _db;

  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();

  Future<Database?> get database async {
    if (_db == null) {
      await createDB();
    }
    return _db;
  }

  Future<void> createDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, "auction.db");

    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      String productsQuery =
          "CREATE TABLE IF NOT EXISTS auctions_products (product_id INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT);";
      await db.execute(productsQuery);
    });
  }

  Future<int> insertProduct({required DbModel model}) async {
    final db = await database;

    String query = "INSERT INTO auctions_products(product_name) VALUES(?);";
    List<dynamic> res = [model.name];

    int id = await db!.rawInsert(query, res);
    return id;
  }

  Future<List<DbModel>> fetchData() async {
    final db = await database;
    String query = "SELECT * FROM auctions_products;";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    List<DbModel> products = res.map((e) => DbModel.fromMap(e)).toList();
    return products;
  }

  Future<int> updateData({required DbModel model, required int id}) async {
    final db = await database;

    String query =
        "UPDATE auctions_products SET product_name = ?, WHERE product_id = ?;";
    List<dynamic> res = [model.name, id];

    int updatedCount = await db!.rawUpdate(query, res);
    return updatedCount;
  }

  Future<int> deleteData({required int id}) async {
    final db = await database;

    String query = "DELETE FROM auctions_products WHERE product_id = ?;";
    int deletedCount = await db!.rawDelete(query, [id]);
    return deletedCount;
  }
}
