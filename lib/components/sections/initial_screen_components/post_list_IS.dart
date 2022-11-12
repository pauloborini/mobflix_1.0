import 'package:flutter/material.dart';
import 'package:mobflix/data/post_dao.dart';
import '../../../screens/edit_post_screen.dart';
import '../../utilities/circular_progress.dart';
import '../../post.dart';

class PostListFront extends StatefulWidget {
  const PostListFront({Key? key}) : super(key: key);

  @override
  State<PostListFront> createState() => _PostListFrontState();
}

class _PostListFrontState extends State<PostListFront> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: PostDao().findAll(),
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
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Post post = items[index];
                    return Dismissible(
                      key: ValueKey<Post>(post),
                      direction: DismissDirection.horizontal,
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmação"),
                                content:
                                    const Text("Você quer deletar a postagem?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        PostDao().delete(post.linkyoutube);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('Post apagado')));
                                      },
                                      child: const Text(
                                        "DELETAR",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
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
                                content:
                                    const Text("Você quer editar a postagem?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => EditPostScreen(
                                              post.id!,
                                              post.linkyoutube,
                                              post.nameCategory,
                                              post.colorCategory),
                                        ));
                                      },
                                      child: const Text(
                                        "EDITAR",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.green),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      background: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
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
                  Text('Adicione uma postagem', style: TextStyle(fontSize: 20))
                ],
              ),
            ));
        }
        return const Text('Aguarde...');
      },
    );
  }
}
