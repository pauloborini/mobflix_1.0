import 'package:flutter/material.dart';
import 'package:mobflix/components/sections/category_slider_front.dart';
import 'package:mobflix/components/sections/banner_highlight_front.dart';
import 'package:mobflix/components/sections/mobflix_title.dart';
import '../components/sections/post_list_front.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}


class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 290,
          elevation: 0,
          backgroundColor: const Color(0xFF19191A),
          titleSpacing: 0,
          title: Column(children: const [
            MobflixTitle(),
            BannerHighlightFront(),
            RowCategoryFront(),
          ])),
      body: const PostListFront(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/post_screen");
        },
        backgroundColor: const Color(0xff7a60fe),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}