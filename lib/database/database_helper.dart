import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper{
  late Database _database;

  Future<Database> get database async{
    print("get database");
    if (_database == null){
      return _database;
    }
    _database = await createDatabase();

    return _database; 
  }
  
  Future<Database> createDatabase() async{
    String dbName = "worksday_db.db";
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {


        print("Create table type");
        await db.execute(
          "CREATE TABLE type ("
          "id INTEGER PRIMARY KEY,"
          "type_name TEXT,"
          "color TEXT,"
          "default INTEGER"
          ")"
        );

        print("Create table priority");
        await db.execute(
          "CREATE TABLE priority ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "color TEXT,"
          "default INTEGER"
          ")"
        );



        print("Create table Task");
        await db.execute(
          "CREATE TABLE task ("
          "id INTEGER PRIMARY KEY,"
          "taskname TEXT,"
          "time TEXT,"
          "notice_time TEXT,"
          "more TEXT,"
          "image TEXT,"
          "audio TEXT,"
          "type_id INTEGER,"
          "priority_id INTEGER,"
          "repeat INTEGER,"

          "FOREIGN KEY (type_id)" 
          "REFERENCES type (id)" 
          " ON DELETE CASCADE" 
          " ON UPDATE NO ACTION,"

          "FOREIGN KEY (priority_id)" 
          "REFERENCES priority (id)" 
          " ON DELETE CASCADE" 
          " ON UPDATE NO ACTION,"
          ")"
        );
        print("Create table repeat_list");
        await db.execute(
          "CREATE TABLE repeat ("
          "id INTEGER PRIMARY KEY,"
          "task_id INTERGER,"
          "time TEXT,"

          "FOREIGN KEY (task_id)" 
          "REFERENCES task (id)" 
          " ON DELETE CASCADE" 
          " ON UPDATE NO ACTION,"
          ")"
        );

        print ("Create success");
      }
      
      
    );
  }
}