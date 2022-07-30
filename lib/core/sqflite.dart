import 'package:flutter_blog_firebase/core/constants/sqflite_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class SqfLiteLocalDataModel {
  String id;

  SqfLiteLocalDataModel(this.id);

  SqfLiteLocalDataModel.fromMap(Map map) : id = map[SqfLiteConstants.idColumn];

  Map<String, dynamic> toMap() {
    return {
      SqfLiteConstants.idColumn: id,
    };
  }
}

typedef FromSqfLite<T> = T Function(
  Map data,
);

class SqfLiteLocalDataSource<T extends SqfLiteLocalDataModel> {
  final Database db;
  final String tableName;

  final FromSqfLite<T> fromSqfLite;

  SqfLiteLocalDataSource(this.db, this.tableName, this.fromSqfLite);

  Future<List<T>> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return fromSqfLite(maps[i]);
    });
  }

  Future<T> add(T row) async {
    await db.insert(tableName, row.toMap());
    return row;
  }

  // add all
  Future<List<T>> addAll(List<T> rows) async {
    final batch = db.batch();
    for (var row in rows) {
      batch.insert(tableName, row.toMap());
    }
    final result = await batch.commit();
    return rows;
  }

  Future<T?> getOne(String id) async {
    List<Map> maps = await db.query(tableName,
        where: '${SqfLiteConstants.idColumn} = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return fromSqfLite(maps.first);
    }
    return null;
  }

  Future<int> delete(String id) async {
    return await db.delete(tableName,
        where: '${SqfLiteConstants.idColumn} = ?', whereArgs: [id]);
  }

  Future<int> update(T row) async {
    return await db.update(tableName, row.toMap(),
        where: '${SqfLiteConstants.idColumn} = ?', whereArgs: [row.id]);
  }
}
