import 'package:flutter/material.dart';
import 'package:mobflix/data/post_dao.dart';
import '../components/post.dart';

class FormPost extends StatefulWidget {
  const FormPost({
    Key? key,
  }) : super(key: key);

  @override
  State<FormPost> createState() => _FormPostState();
}

class _FormPostState extends State<FormPost> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();
  String categoriaController = '';
  int corController = 0;
  final String noPhoto = 'assets/images/noLink.png';
  int _indexController = 0;
  bool opacidade = false;

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

  get videoId => convertUrlToId(urlController.text);

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> mapCat = {
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

    final List<String> listaKeys = mapCat.keys.toList();
    final List<int> listaValues = mapCat.values.toList();

    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: const Color(0xFF222223),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      /// BOTÃO DE VOLTAR - INICIO
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed("/dashboard");
                      },
                      child: SizedBox(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back_ios_new,
                              size: 24,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// BOTÃO DE VOLTAR
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 8, 30, 30),
                      child: Text(
                        'Cadastre um vídeo',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        'URL:',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      /// FORM URL - INICIO
                      padding: const EdgeInsets.fromLTRB(30, 4, 30, 24),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Insira a URL corretamente';
                          }
                          return null;
                        },
                        controller: urlController,
                        onChanged: (text) {
                          setState(() {});
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFF275EA3),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8)),
                          hintText:
                              ' https://www.youtube.com/watch?v=5xoyGr4QF3o',
                          hintStyle: const TextStyle(
                              color: Colors.white54,
                              fontFamily: 'Roboto',
                              fontSize: 13),
                          filled: true,
                        ),
                      ),
                    ),

                    /// FORM URL
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        'Categoria:',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ), //
                    Padding(
                      /// DROPDOWN BUTTON - INICIO
                      padding: const EdgeInsets.fromLTRB(30, 4, 30, 24),
                      child: DropdownButtonFormField(
                          items: mapCat.keys
                              .map<DropdownMenuItem<String>>((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(key),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              opacidade = true;
                              _indexController = (listaKeys.indexOf(value!));
                              categoriaController = listaKeys[_indexController];
                              corController = listaValues[_indexController];
                            });
                          },
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF275EA3),
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
                    ),

                    /// DROPDOWN BUTTON
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 8),
                      child: Text(
                        'Preview',
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      /// PREVIEW - INICIO
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: AnimatedOpacity(
                        opacity: opacidade ? 1 : 0,
                        duration: const Duration(milliseconds: 100),
                        child: SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Color(corController)),
                            child: Text(categoriaController),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                noPhoto,
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    /// PREVIEW
                    Padding(
                      /// CADASTRAR BUTTON - INICIO
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final int idCorreto =
                                  await PostDao().pegarTamanhoDB();

                              await PostDao().save(Post(
                                  idCorreto,
                                  urlController.text,
                                  categoriaController,
                                  corController));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Post criado'),
                                ),
                              );
                              Navigator.of(context)
                                  .pushReplacementNamed("/dashboard");
                            }
                          },
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    /// CADASTRAR BUTTON
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}