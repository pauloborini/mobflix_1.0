import '../components/post.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class PostDao {
  static const String tableSql = 'CREATE TABLE $_posttable('
      '$_id INTEGER PRIMARY KEY, '
      '$_linkyoutube TEXT, '
      '$_nomeCategoria TEXT, '
      '$_corCategoria INTEGER)';

  static const String _posttable = 'postTable';
  static const String _id = 'id';
  static const String _linkyoutube = 'linkyoutube';
  static const String _nomeCategoria = 'nomeCategoria';
  static const String _corCategoria = 'corCategoria';

  save(Post postagem) async {
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(postagem.linkyoutube);
    if (itemExists.isEmpty) {
      return await bancoDeDados.insert(_posttable, _toMap(postagem));
    } else {
      return await bancoDeDados.update(_posttable, _toMap(postagem),
          where: '$_linkyoutube = ?', whereArgs: [postagem.linkyoutube]);
    }
  }

  Future<int> pegarTamanhoDB() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_posttable);
    if (result.isEmpty) {
      const int varParaID = 1;
      return varParaID;
    } else {
      int id = result.length;
      final varParaID = id++;
      return varParaID;
    }
  }

  Future<List<Post>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_posttable);
    return toList(result);
  }

  Future<List<Post>> find(String categoriaBuscada) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
        _posttable,
        where: '$_nomeCategoria = ?',
        whereArgs: [categoriaBuscada]);
    return toList(result);
  }

  delete(String linkdaPostagem) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_posttable,
        where: '$_linkyoutube = ?', whereArgs: [linkdaPostagem]);
  }

  List<Post> toList(List<Map<String, dynamic>> listaDePostagens) {
    final List<Post> postagens = [];
    for (Map<String, dynamic> linha in listaDePostagens) {
      final Post postagem = Post(
        linha[_id],
        linha[_linkyoutube],
        linha[_nomeCategoria],
        linha[_corCategoria],
      );
      postagens.add(postagem);
    }
    return postagens;
  }

  Map<String, dynamic> _toMap(Post postagem) {
    final Map<String, dynamic> mapaPostagem = {};
    mapaPostagem[_linkyoutube] = postagem.linkyoutube;
    mapaPostagem[_nomeCategoria] = postagem.nomeCategoria;
    mapaPostagem[_corCategoria] = postagem.corCategoria;
    return mapaPostagem;
  }
}
