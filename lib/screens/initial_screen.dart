
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobflix/components/sections/category_slider_front.dart';
import 'package:mobflix/components/sections/banner_highlight_front.dart';
import 'package:mobflix/components/sections/mobflix_title_front.dart';
import '../components/sections/post_list_front.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final Color stanColor = const Color(0xFF222223);
  final Color appBarFront = const Color(0xFF19191A);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(

              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent
              ),
                forceElevated: innerBoxIsScrolled,
                toolbarHeight: 280,
                elevation: 0,
                backgroundColor: appBarFront,
                titleSpacing: 0,
                title: Column(children: const [
                  MobflixTitle(),
                  BannerHighlightFront(),
                  RowCategoryFront(),
                ])),
          ];
        },
        body: Container(
            color: stanColor,
            child: PostListFront()),
      ),
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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//         toolbarHeight: 290,
//         elevation: 0,
//         backgroundColor: const Color(0xFF19191A),
//         titleSpacing: 0,
//         title: Column(children: const [
//           MobflixTitle(),
//           BannerHighlightFront(),
//           RowCategoryFront(),
//         ])),
//     body: const PostListFront(),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         Navigator.of(context).pushReplacementNamed("/post_screen");
//       },
//       backgroundColor: const Color(0xff7a60fe),
//       child: const Icon(
//         Icons.add,
//         size: 40,
//       ),
//     ),
//   );
// }
// }
