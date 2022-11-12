import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utilities/colors_and_vars.dart';
import 'utilities/functions.dart';

class Post extends StatefulWidget {
  final int? id;
  final String linkyoutube;
  final String nameCategory;
  final int colorCategory;

  Post(
      {super.key,
      this.id,
      required this.linkyoutube,
      required this.nameCategory,
      required this.colorCategory});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  get videoId => convertUrlToId(widget.linkyoutube);

  Future<void> _launchURL2() async {
    if (!await launchUrl(
        Uri.parse('https://m.youtube.com/watch?v=${widget.linkyoutube}'))) {
      throw 'Não foi possível abrir essa URL';
    }
  }

  Future<void> _launchURL() async {
    if (!await launchUrl(Uri.parse(widget.linkyoutube))) {
      throw 'Não foi possível abrir essa URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: stanColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(widget.colorCategory)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
              child: Text(widget.nameCategory,
                  style: const TextStyle(fontSize: 16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                width: 342,
                height: 185,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://img.youtube.com/vi/$videoId/0.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                  child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    if (widget.linkyoutube.length == 11) {
                      _launchURL2();
                    }
                    _launchURL();
                  },
                ),
              ))
            ]),
          ),
        ],
      ),
    );
  }
}
