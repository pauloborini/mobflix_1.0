import 'package:flutter/material.dart';
import '../category_button.dart';

class RowCategoryFront extends StatelessWidget {
  const RowCategoryFront({Key? key}) : super(key: key);


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
              CategoryButtonFront(
                  colorCategory: Color(-14049492), nameCategory: 'Ação', searchCategory: 'Ação',),
              CategoryButtonFront(
                  colorCategory: Color(-13251864), nameCategory: 'Animação', searchCategory: 'Animação',),
              CategoryButtonFront(
                  colorCategory: Color(-2350542), nameCategory: 'Terror', searchCategory: 'Terror',),
              CategoryButtonFront(
                  colorCategory: Color(-16777216), nameCategory: 'Suspense', searchCategory: 'Suspense',),
              CategoryButtonFront(
                  colorCategory: Color(-13251864), nameCategory: 'Aventura', searchCategory: 'Aventura',),
              CategoryButtonFront(
                  colorCategory: Color(-14049492),
                  nameCategory: 'Ficção Científica', searchCategory: 'Ficção Científica',),
              CategoryButtonFront(
                  colorCategory: Color(-13251864), nameCategory: 'Comédia', searchCategory: 'Comédia',),
              CategoryButtonFront(
                  colorCategory: Color(-14049492), nameCategory: 'Médicas', searchCategory: 'Médicas',),
              CategoryButtonFront(
                  colorCategory: Color(-2350542), nameCategory: 'Romance', searchCategory: 'Romance',),
              CategoryButtonFront(
                  colorCategory: Color(-14583081), nameCategory: 'Fantasia', searchCategory: 'Fantasia',),
              CategoryButtonFront(
                  colorCategory: Color(-3695864), nameCategory: 'Espionagem', searchCategory: 'Espionagem',),
              CategoryButtonFront(
                  colorCategory: Color(-16777216), nameCategory: 'Musical', searchCategory: 'Musical',),
              CategoryButtonFront(
                  colorCategory: Color(-3695864), nameCategory: 'Policial', searchCategory: 'Policial',),
              CategoryButtonFront(
                  colorCategory: Color(-14583081), nameCategory: 'Drama', searchCategory: 'Drama',),
              CategoryButtonFront(
                  colorCategory: Color(-13251864), nameCategory: 'Guerra', searchCategory: 'Guerra',),
            ],
          ),
        ),
      ),
    );
  }
}

