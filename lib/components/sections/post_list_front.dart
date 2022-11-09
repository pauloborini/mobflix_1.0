import 'package:flutter/material.dart';
import 'package:mobflix/data/post_dao.dart';
import '../circular_progress.dart';
import '../post.dart';

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
                  reverse: false,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Post posts = items[index];
                    return Dismissible(
                      key: ValueKey<Post>(posts),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        setState(() {});
                      },
                      confirmDismiss:
                          (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmação"),
                              content: const Text(
                                  "Você quer deletar a postagem?"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      PostDao().delete(
                                          posts.linkyoutube);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  '${posts.linkyoutube} apagada')));
                                    },
                                    child: const Text("Deletar")),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("Cancelar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      background: Container(
                        color: const Color(0xFF222223),
                        child: const Align(
                          alignment: Alignment(-0.9, 0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                      child: Container(child: posts),
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
                  Text('Adicione uma postagem',
                      style: TextStyle(fontSize: 20))
                ],
              ),
            ));
        }
        return const Text('Aguarde...');
      },
    );
  }
}
