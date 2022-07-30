import 'package:flutter_blog_firebase/core/constants/sqflite_constants.dart';
import 'package:flutter_blog_firebase/core/sqflite.dart';
import 'package:flutter_blog_firebase/features/posts/data/local/models/post_local_data_model.dart';
import 'package:sqflite/sqflite.dart';

class PostsLocaleDataSource extends SqfLiteLocalDataSource<PostLocalDataModel> {
  final Database database;

  PostsLocaleDataSource(this.database)
      : super(database, SqfLiteConstants.postsTable,
            (map) => PostLocalDataModel.fromMap(map));
}
