import 'package:flutter/material.dart';
import '../components/botao_categoria.dart';
import '../components/circular_progress.dart';
import '../components/post.dart';
import '../data/post_dao.dart';

class FindScreen extends StatefulWidget {
  const FindScreen({
    Key? key,
    required this.categoriaBuscada,
    required this.nomeCategoria,
    required this.corCategoria,
  }) : super(key: key);

  final String categoriaBuscada;
  final String nomeCategoria;
  final Color corCategoria;

  @override
  State<FindScreen> createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF19191A),
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 12),
          child: Text(
            'MOBFLIX',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF2478DF),
                fontFamily: 'BebasNeue'),
          ),
        ),
        toolbarHeight: 79,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF222223),
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 15, 24, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categoria:',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  BotaoCategoriaFront(
                    nomeCategoria: widget.nomeCategoria,
                    corCategoria: widget.corCategoria,
                    buscaCategoria: widget.categoriaBuscada,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFF222223),
              width: double.maxFinite,
              height: double.maxFinite,
              child: FutureBuilder<List<Post>>(
                future: PostDao().find(widget.categoriaBuscada),
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
                              final Post postagens = items[index];
                              return Dismissible(
                                key: ValueKey<Post>(postagens),
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
                                                    postagens.linkyoutube);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            '${postagens.linkyoutube} apagada')));
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
                                child: Container(child: postagens),
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
                            Text('Sem postagens dessa categoria',
                                style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ));
                  }
                  return const Text('Unknown Error');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
