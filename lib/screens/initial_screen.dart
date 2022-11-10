<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/sections/banner_highlight_front.dart';
import '../components/sections/category_slider_front.dart';
import '../components/sections/mobflix_title_front.dart';
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

