import '../components/post.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class PostDao {
  static const String tableSql = 'CREATE TABLE $_postsTable('
      '$_id INTEGER PRIMARY KEY, '
      '$_linkyoutube TEXT, '
      '$_nameCategory TEXT, '
      '$_colorCategory INTEGER)';

  static const String _postsTable = 'postsTable';
  static const String _id = 'id';
  static const String _linkyoutube = 'linkyoutube';
  static const String _nameCategory = 'nameCategory';
  static const String _colorCategory = 'colorCategory';

  save(Post post) async {
    final Database dataBaselocal = await getDatabase();
    var itemExists = await find(post.linkyoutube);
    if (itemExists.isEmpty) {
      return await dataBaselocal.insert(_postsTable, _toMap(post));
    } else {
      return await dataBaselocal.update(_postsTable, _toMap(post),
          where: '$_linkyoutube = ?', whereArgs: [post.linkyoutube]);
    }
  }

  Future<int> getLengthDB() async {
    final Database dataBaselocal = await getDatabase();
    final List<Map<String, dynamic>> result =
        await dataBaselocal.query(_postsTable);
    if (result.isEmpty) {
      const int varForID = 1;
      return varForID;
    } else {
      int id = result.length;
      final varForID = id++;
      return varForID;
    }
  }

  Future<List<Post>> findAll() async {
    final Database dataBaselocal = await getDatabase();
    final List<Map<String, dynamic>> result =
        await dataBaselocal.query(_postsTable);
    return toList(result);
  }

  Future<List<Post>> find(String selectedCategory) async {
    final Database dataBaselocal = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBaselocal.query(
        _postsTable,
        where: '$_nameCategory = ?',
        whereArgs: [selectedCategory]);
    return toList(result);
  }

  delete(String linkpost) async {
    final Database dataBaselocal = await getDatabase();
    return dataBaselocal.delete(_postsTable,
        where: '$_linkyoutube = ?', whereArgs: [linkpost]);
  }

  List<Post> toList(List<Map<String, dynamic>> postsList) {
    final List<Post> posts = [];
    for (Map<String, dynamic> row in postsList) {
      final Post post = Post(
        row[_id],
        row[_linkyoutube],
        row[_nameCategory],
        row[_colorCategory],
      );
      posts.add(post);
    }
    return posts;
  }

  Map<String, dynamic> _toMap(Post post) {
    final Map<String, dynamic> postMap = {};
    postMap[_linkyoutube] = post.linkyoutube;
    postMap[_nameCategory] = post.nameCategory;
    postMap[_colorCategory] = post.colorCategory;
    return postMap;
  }
}
