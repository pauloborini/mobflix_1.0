import 'package:flutter/material.dart';
import 'package:mobflix/components/sections/categorias.dart';
import 'package:mobflix/components/sections/destaque_front.dart';
import 'package:mobflix/components/sections/mobflix_title.dart';
import '../components/sections/lista_postagens.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {
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
            DestaqueFront(),
            CategoriasFront(),
          ])),
      body: const ListaPostagens(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/post");
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
//
//
// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//
//                 toolbarHeight: 290,
//                 backgroundColor: const Color(0xFF19191A),
//                 titleSpacing: 0,
//                 title: Column(
//                   children: [
//                     MobflixTitle(),
//                     DestaqueFront(),
//                     CategoriasFront(),
//                   ],
//                 ),
//                 elevation: 0,
//                 expandedHeight: 0,
//               )
//             ];
//           },
//           body: ListaPostagens(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).pushReplacementNamed("/post");
//           },
//           backgroundColor: const Color(0xff7a60fe),
//           child: const Icon(
//             Icons.add,
//             size: 40,
//           ),
//         ));
//   }
// }
