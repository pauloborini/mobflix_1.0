import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/sections/initial_screen_components/banner_highlight_IS.dart';
import '../components/sections/initial_screen_components/category_slider_IS.dart';
import '../components/sections/initial_screen_components/mobflix_title_IS.dart';
import '../components/sections/initial_screen_components/post_list_IS.dart';
import '../components/utilities/colors_and_vars.dart';
import 'form_post_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent),
                forceElevated: innerBoxIsScrolled,
                toolbarHeight: 260,
                elevation: 0,
                backgroundColor: appBarFront,
                titleSpacing: 0,
                title: Column(children: const [
                  MobflixTitle(),
                  BannerHighlightFront(),
                  CategorySliderFront(),
                ])),
          ];
        },
        body: Container(color: stanColor, child: PostListFront()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const FormPostScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
