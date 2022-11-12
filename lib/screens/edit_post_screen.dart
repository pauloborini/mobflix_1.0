import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import '../components/base_app_bar.dart';
import '../components/post.dart';
import '../components/utilities/colors_and_vars.dart';
import '../components/utilities/functions.dart';
import '../data/post_dao.dart';

class EditPostScreen extends StatefulWidget {
  int? id;
  String linkyoutube;
  String nameCategory;
  int colorCategory;

  EditPostScreen(
      this.id, this.linkyoutube, this.nameCategory, this.colorCategory,
      {super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreen();
}

class _EditPostScreen extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  String _categoryController = '';
  int _colorController = 0;
  int _indexController = 0;
  bool opacity = false;

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

  final List<String> keysList = categoryMap.keys.toList();
  final List<int> valuesList = categoryMap.values.toList();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: stanColor,
        appBar: BaseAppBar(title: 'Editar vídeo', appBar: AppBar()),
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
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 20),
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
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        var formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          await PostDao().update(Post(
                              id: widget.id,
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        'Atualizar',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
