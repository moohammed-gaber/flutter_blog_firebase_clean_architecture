import 'package:flutter_blog_firebase/core/constants/sqflite_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceInitializer {
  late final Database database;

  LocalDataSourceInitializer();

  createTable(Database db) async {
    return db.execute(
        'CREATE TABLE `${SqfLiteConstants.postsTable}` (${SqfLiteConstants.idColumn} TEXT NOT NULL, `${SqfLiteConstants.descriptionColumn}` TEXT NOT NULL, `${SqfLiteConstants.imageUrlColumn}` TEXT NOT NULL  )');
  }

  Future<Database> openDatabaseConnection() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '${SqfLiteConstants.postsTable}.db');
    database = await openDatabase(path, version: 11,
        onCreate: (Database db, int version) async {
      await createTable(db);
      print('onCreate');
    }, onUpgrade: (db, ___, __) async {
      print('onUpgrade');
      await db.execute('DROP TABLE IF EXISTS `${SqfLiteConstants.postsTable}`');
      await createTable(db);
    });
    return database;
  }

  Future<void> closeDatabaseConnection() async {
    return database.close();
  }
}
