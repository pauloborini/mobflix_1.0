import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DestaqueFront extends StatelessWidget {
  const DestaqueFront({super.key});


  @override
  Widget build(BuildContext context) {
    return const ImageSlideshow(
        width: double.maxFinite,
        height: 145,
        initialPage: 0,
        indicatorColor: Colors.white,
        indicatorBackgroundColor: Colors.grey,
        autoPlayInterval: 3000,
        isLoop: true,
        children: [ Destaque(urlFotoDestaque: 'https://img.youtube.com/vi/IlGXupyQk-M/0.jpg',
            urlTrailerDestaque: 'https://www.youtube.com/watch?v=IlGXupyQk-M'),
          Destaque(urlFotoDestaque: 'https://img.youtube.com/vi/JFDMIjo7PbE/0'
              '.jpg', urlTrailerDestaque: 'https://www.youtube.com/watch?v=JFDMIjo7PbE'),
          Destaque(urlFotoDestaque: 'https://img.youtube.com/vi/FR9iLjOubWc/0'
              '.jpg', urlTrailerDestaque: 'https://www.youtube.com/watch?v=FR9iLjOubWc'),
          Destaque(urlFotoDestaque: 'https://img.youtube.com/vi/l6JItoLw9PQ/0'
              '.jpg', urlTrailerDestaque: 'https://www.youtube.com/watch?v=l6JItoLw9PQ'),
        ]);
  }
}


class Destaque extends StatelessWidget {
  const Destaque(
      {Key? key, required this.urlFotoDestaque, required this.urlTrailerDestaque})
      : super(key: key);

  final String urlFotoDestaque;
  final String urlTrailerDestaque;


  Future<void> _launchURL() async {
    if (!await launchUrl(Uri.parse(urlTrailerDestaque))) {
      throw 'Não foi possível abrir essa URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          color: const Color(0xFF19191A),
          width: double.infinity,
          height: 145,
          child: Image.network(
            urlFotoDestaque,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 3.0),
                backgroundColor: const Color(0xFF2477DE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onPressed: () {
              _launchURL();
            },
            child: const Text(
              'Assista agora',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ]
    );
  }
}
