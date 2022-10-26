import 'package:flutter/material.dart';
import 'package:mobflix/components/botao_categoria.dart';

class CategoriasFront extends StatelessWidget {
  const CategoriasFront({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 1650,
        height: 70,
        color: const Color(0xFF222223),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              BotaoCategoriaFront(
                  corCategoria: Color(-14049492), nomeCategoria: 'Ação', buscaCategoria: 'Ação',),
              BotaoCategoriaFront(
                  corCategoria: Color(-13251864), nomeCategoria: 'Animação', buscaCategoria: 'Animação',),
              BotaoCategoriaFront(
                  corCategoria: Color(-2350542), nomeCategoria: 'Terror', buscaCategoria: 'Terror',),
              BotaoCategoriaFront(
                  corCategoria: Color(-16777216), nomeCategoria: 'Suspense', buscaCategoria: 'Suspense',),
              BotaoCategoriaFront(
                  corCategoria: Color(-13251864), nomeCategoria: 'Aventura', buscaCategoria: 'Aventura',),
              BotaoCategoriaFront(
                  corCategoria: Color(-14049492),
                  nomeCategoria: 'Ficção Científica', buscaCategoria: 'Ficção Científica',),
              BotaoCategoriaFront(
                  corCategoria: Color(-13251864), nomeCategoria: 'Comédia', buscaCategoria: 'Comédia',),
              BotaoCategoriaFront(
                  corCategoria: Color(-14049492), nomeCategoria: 'Médicas', buscaCategoria: 'Médicas',),
              BotaoCategoriaFront(
                  corCategoria: Color(-2350542), nomeCategoria: 'Romance', buscaCategoria: 'Romance',),
              BotaoCategoriaFront(
                  corCategoria: Color(-14583081), nomeCategoria: 'Fantasia', buscaCategoria: 'Fantasia',),
              BotaoCategoriaFront(
                  corCategoria: Color(-3695864), nomeCategoria: 'Espionagem', buscaCategoria: 'Espionagem',),
              BotaoCategoriaFront(
                  corCategoria: Color(-16777216), nomeCategoria: 'Musical', buscaCategoria: 'Musical',),
              BotaoCategoriaFront(
                  corCategoria: Color(-3695864), nomeCategoria: 'Policial', buscaCategoria: 'Policial',),
              BotaoCategoriaFront(
                  corCategoria: Color(-14583081), nomeCategoria: 'Drama', buscaCategoria: 'Drama',),
              BotaoCategoriaFront(
                  corCategoria: Color(-13251864), nomeCategoria: 'Guerra', buscaCategoria: 'Guerra',),
            ],
          ),
        ),
      ),
    );
  }
}

