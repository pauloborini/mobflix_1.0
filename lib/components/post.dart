import 'package:flutter/material.dart';
import 'package:mobflix/screens/edit_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Post extends StatefulWidget{
  final String linkyoutube;
  final String nameCategory;
  final int colorCategory;

  Post(this.linkyoutube, this.nameCategory, this.colorCategory,
      {super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }
    return null;
  }

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
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Color(widget.colorCategory)),
              onPressed: () {},
              child: Text(widget.nameCategory,
                  style: const TextStyle(fontSize: 16))),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      onLongPress: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) =>
                                EditPostScreen()));
                      },
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
