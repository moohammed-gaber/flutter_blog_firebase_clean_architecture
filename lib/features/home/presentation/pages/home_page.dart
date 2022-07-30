import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/features/home/presentation/widgets/home_drawer/home_drawer.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_blog_firebase/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*
    final post1 = Post(
        description: 'description',
        imageUrl: 'imageUrl',
        id: '1',
        likesCount: 0);
    final post2 = Post(
        description: 'description',
        imageUrl: 'imageUrl',
        id: '1',
        likesCount: 0);
    print(post1 == post2);
    print(([post1, post2] == [post1, post2]).toString() + 'EEE');
*/
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          titleSpacing: -10,
          title: const Text('الرئيسية'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'الرئيسية',
              ),
              Tab(
                text: 'حسابي',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[PostsPage(), ProfilePage()],
        ),
      ),
    );
  }
}
