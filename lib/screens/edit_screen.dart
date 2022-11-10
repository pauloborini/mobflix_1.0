import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< Updated upstream
import 'package:mobflix/data/post_dao.dart';
import 'package:validatorless/validatorless.dart';
import '../components/post.dart';
=======
import 'package:validatorless/validatorless.dart';
import '../components/post.dart';
import '../data/post_dao.dart';
>>>>>>> Stashed changes

class EditPostScreen extends StatefulWidget {
  String linkyoutube;
  String nameCategory;
  int colorCategory;

  EditPostScreen(this.linkyoutube, this.nameCategory, this.colorCategory,
      {super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreen();
}

class _EditPostScreen extends State<EditPostScreen> {
  final Color stanColor = const Color(0xFF222223);
  final Color fillColorForm = const Color(0xFF275EA3);
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  String _categoryController = '';
  int _colorController = 0;
  final String noPhoto = 'assets/images/noLink.png';
  int _indexController = 0;
  bool opacity = false;

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

  get videoId => convertUrlToId(_urlController.text);

  @override
  void initState() {
    super.initState();
    _urlController.text = widget.linkyoutube;
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> categoryMap = {
      'Ação': -14049492,
      'Terror': -2350542,
      'Suspense': -16777216,
      'Aventura': -13251864,
      'Ficção Científica': -14049492,
      'Animação': -13251864,
      'Drama': -14583081,
      'Comédia': -13251864,
      'Médicas': -14049492,
      'Romance': -2350542,
      'Fantasia': -14583081,
      'Espionagem': -3695864,
      'Musical': -16777216,
      'Policial': -3695864,
      'Guerra': -13251864,
    };
    final List<String> keysList = categoryMap.keys.toList();
    final List<int> valuesList = categoryMap.values.toList();

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: stanColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: stanColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/initial_screen', ModalRoute.withName('/'));
              },
              child: const Icon(Icons.arrow_back_ios_new)),
          title: const Text(
            'Edite o vídeo',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            color: stanColor,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 4),
                    child: Text(
                      'URL:',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  TextFormField(
                    validator: Validatorless.required('Preencha com uma URL'),
                    controller: _urlController,
                    onChanged: (text) {
                      setState(() {});
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      fillColor: fillColorForm,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8)),
                      hintText: ' https://www.youtube.com/watch?v=5xoyGr4QF3o',
                      hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontFamily: 'Roboto',
                          fontSize: 13),
                      filled: true,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 4),
                    child: Text(
                      'Categoria:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //
                  DropdownButtonFormField(
                      validator:
                          Validatorless.required('Selecione uma categoria'),
                      items: categoryMap.keys
                          .map<DropdownMenuItem<String>>((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(key),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          opacity = true;
                          _indexController = (keysList.indexOf(value!));
                          _categoryController = keysList[_indexController];
                          _colorController = valuesList[_indexController];
                        });
                      },
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: fillColorForm,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        hintText: '  Ex: Terror, Drama, Comédia...',
                        hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontFamily: 'Roboto',
                            fontSize: 16),
                        filled: true,
                      )),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
                    child: Text(
                      'Preview',
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: opacity ? 1 : 0,
                    duration: const Duration(milliseconds: 100),
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Color(_colorController)),
                        child: Text(_categoryController),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
                    child: Container(
                      height: 180,
                      width: 330,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          'https://img.youtube.com/vi/$videoId/0.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              noPhoto,
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        var formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          await PostDao().update(Post(
                              linkyoutube: _urlController.text,
                              nameCategory: _categoryController,
                              colorCategory: _colorController));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Post atualizado'),
                            ),
                          );
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/initial_screen', ModalRoute.withName('/'));
                        }
                      },
                      child: const Text(
                        'Atualizar',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          PostDao().delete(widget.linkyoutube);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${widget.linkyoutube} apagada')));

                          Navigator.pushNamedAndRemoveUntil(context,
                              '/initial_screen', ModalRoute.withName('/'));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text(
                          'Remover',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
