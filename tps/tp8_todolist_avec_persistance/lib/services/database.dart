import 'package:mon_gestionnaire_de_tache/util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClient {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), "todolist");
    // Update the version if database schema change
    return await openDatabase(path,
        version: 1,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDowngrade);
  }

  onCreate(Database database, int version) async {
    await _createTaskTable(database, version);
  }

  // Apply the right migration
  onUpgrade(Database database, int oldVersion, int newVersion) async {
    // Comment it for next migrations when we will be on version 2
    // if (oldVersion == 1) {
    //   await DatabaseMigration(db: database).migrateV1ToV2();
    // }
  }

  // Revert the change
  onDowngrade(Database database, int oldVersion, int newVersion) async {}

  Future<void> _createTaskTable(Database database, int version) async {
    await database.execute('DROP TABLE IF EXISTS ${Constant.taskTableName}');
    // Define the variable of version query
    final String queryVersion1 =
        "CREATE TABLE ${Constant.taskTableName}(createdDate TEXT NOT NULL, id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, isEnded INTEGER DEFAULT 0)";
    // Create the table according to version
    switch (version) {
      case 1:
        await database.execute(queryVersion1);
        break;
      default:
        await database.execute(queryVersion1);
        break;
    }
  }
}
