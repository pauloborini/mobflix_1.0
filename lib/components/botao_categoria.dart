import 'package:flutter/material.dart';
import 'package:mobflix/data/post_dao.dart';
import 'package:mobflix/screens/find_screen.dart';

class BotaoCategoriaFront extends StatelessWidget {
  final String nomeCategoria;
  final Color corCategoria;
  final String buscaCategoria;

  const BotaoCategoriaFront(
      {super.key,
      required this.nomeCategoria,
      required this.corCategoria,
      required this.buscaCategoria});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: corCategoria),
          onPressed: () {
            PostDao().find(buscaCategoria);
            Navigator.of(context).push(MaterialPageRoute(builder: (contextNew) {
              return FindScreen(
                  categoriaBuscada: buscaCategoria,
                  nomeCategoria: nomeCategoria,
                  corCategoria: corCategoria);
            }));
          },
          child: Text(
            nomeCategoria,
            style: const TextStyle(fontSize: 16),
          )),
    );
  }
}
