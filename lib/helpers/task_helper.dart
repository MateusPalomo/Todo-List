import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list2/models/task3.dart';

class Task3Helper {
  static final Task3Helper _instance = Task3Helper.internal();

  factory Task3Helper() => _instance;

  Task3Helper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "todo_list.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE task3("
          "id INTEGER PRIMARY KEY, "
          "title TEXT, "
          "description TEXT, "
          "isDone INTEGER)");
    });
  }

  Future<int> getCount() async {
    Database database = await db;
    return Sqflite.firstIntValue(
        await database.rawQuery("SELECT COUNT(*) FROM task3"));
  }

  Future close() async {
    Database database = await db;
    database.close();
  }

  Future<Task3> save(Task3 task3) async {
    Database database = await db;
    task3.id = await database.insert('task3', task3.toMap());
    return task3;
  }

  Future<Task3> getById(int id) async {
    Database database = await db;
    List<Map> maps = await database.query('task3',
        columns: ['id', 'title', 'description', 'isDone'],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Task3.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete('task3', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database database = await db;
    return await database.rawDelete("DELETE * from task3");
  }

  Future<int> update(Task3 task3) async {
    Database database = await db;
    return await database
        .update('task3', task3.toMap(), where: 'id = ?', whereArgs: [task3.id]);
  }

  Future<List<Task3>> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM task3");
    List<Task3> stuffList = listMap.map((x) => Task3.fromMap(x)).toList();
    return stuffList;
  }
}
