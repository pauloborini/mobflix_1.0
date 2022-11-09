import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'post_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'postTable.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(PostDao.tableSql);
    },
    version: 1,
  );
}
