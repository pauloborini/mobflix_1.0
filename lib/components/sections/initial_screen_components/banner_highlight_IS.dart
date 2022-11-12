import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../utilities/colors_and_vars.dart';

class BannerHighlightFront extends StatelessWidget {
  const BannerHighlightFront({super.key});

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
        children: [
          Highlight(
              urlPicHighlight: 'https://img.youtube.com/vi/sh-TMLKMf8M/0.jpg',
              urlTrailerHighlight:
                  'https://www.youtube.com/watch?v=sh-TMLKMf8M'),
          Highlight(
              urlPicHighlight: 'https://img.youtube.com/vi/JFDMIjo7PbE/0'
                  '.jpg',
              urlTrailerHighlight:
                  'https://www.youtube.com/watch?v=JFDMIjo7PbE'),
          Highlight(
              urlPicHighlight: 'https://img.youtube.com/vi/FR9iLjOubWc/0'
                  '.jpg',
              urlTrailerHighlight:
                  'https://www.youtube.com/watch?v=FR9iLjOubWc'),
          Highlight(
              urlPicHighlight: 'https://img.youtube.com/vi/l6JItoLw9PQ/0'
                  '.jpg',
              urlTrailerHighlight:
                  'https://www.youtube.com/watch?v=l6JItoLw9PQ'),
        ]);
  }
}

class Highlight extends StatelessWidget {
  const Highlight(
      {Key? key,
      required this.urlPicHighlight,
      required this.urlTrailerHighlight})
      : super(key: key);

  final String urlPicHighlight;
  final String urlTrailerHighlight;

  Future<void> _launchURL() async {
    if (!await launchUrl(Uri.parse(urlTrailerHighlight))) {
      throw 'Não é possível abrir esta URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Container(
        color: stanColor,
        width: double.infinity,
        height: 145,
        child: Image.network(
          urlPicHighlight,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              backgroundColor: Theme.of(context).primaryColor,
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
    ]);
  }
}
