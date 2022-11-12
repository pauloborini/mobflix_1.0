import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/utilities/category_button.dart';
import '../components/utilities/circular_progress.dart';
import '../components/post.dart';
import '../components/utilities/colors_and_vars.dart';
import '../data/post_dao.dart';
import 'edit_post_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
    required this.selectedCategory,
    required this.nameCategory,
    required this.colorCategory,
  }) : super(key: key);

  final String selectedCategory;
  final String nameCategory;
  final Color colorCategory;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stanColor,
      body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/initial_screen', ModalRoute.withName('/'));
                },
                child: iconArrow,
              ),
              forceElevated: innerBoxIsScrolled,
              centerTitle: true,
              toolbarHeight: 64,
              elevation: 0,
              backgroundColor: appBarFront,
              titleSpacing: 0,
              title: const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 12),
                child: Text(
                  titleFlix,
                  style: TextStyle(
                      fontSize: 32, color: titleColor, fontFamily: 'BebasNeue'),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              color: stanColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 15, 24, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categoria:',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    CategoryButtonFront(
                      nameCategory: widget.nameCategory,
                      colorCategory: widget.colorCategory,
                      searchCategory: widget.selectedCategory,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: stanColor,
                child: FutureBuilder<List<Post>>(
                  future: PostDao().findCategory(widget.selectedCategory),
                  builder: (context, snapshot) {
                    List<Post>? items = snapshot.data?.reversed.toList();
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        break;
                      case ConnectionState.waiting:
                        const CircularProgress('Carregando');
                        break;
                      case ConnectionState.active:
                        const CircularProgress('Carregando');
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasData && items != null) {
                          if (items.isNotEmpty) {
                            return ListView.builder(
                              reverse: false,
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Post post = items[index];
                                return Dismissible(
                                  key: ValueKey<Post>(post),
                                  direction: DismissDirection.horizontal,
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirmação"),
                                            content: const Text(
                                                "Você quer deletar a postagem?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                    PostDao().delete(
                                                        post.linkyoutube);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Post apagado')));
                                                  },
                                                  child: const Text(
                                                    "DELETAR",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.red),
                                                  )),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text(
                                                  "Cancelar",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirmação"),
                                            content: const Text(
                                                "Você quer editar a postagem?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditPostScreen(
                                                              post.id!,
                                                              post.linkyoutube,
                                                              post.nameCategory,
                                                              post.colorCategory),
                                                    ));
                                                  },
                                                  child: const Text(
                                                    "EDITAR",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.green),
                                                  )),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text(
                                                  "Cancelar",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  background: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Container(
                                      color: const Color(0xFF222223),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    child: Container(
                                      color: const Color(0xFF222223),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(child: post),
                                );
                              },
                            );
                          }
                        }
                        return Center(
                            child: SizedBox(
                          width: double.maxFinite,
                          height: 380,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.error_outline,
                                size: 56,
                              ),
                              Text('Sem posts dessa categoria',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ));
                    }
                    return const Text('Erro desconhecido');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
