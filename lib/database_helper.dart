import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model_class.dart';


class DatabaseHelper {
  static const _databaseName = "user_data.db";
  static const _databaseVersion = 1;

  static const table = 'user_table';

  static const columnId = '_id';
  static const columnFirstName = 'first_name';
  static const columnLastName = 'last_name';
  static const columnGender = 'gender';
  static const columnCountryCode = 'country_code';
  static const columnPhoneNumber = 'phone_number';
  static const columnIsUser = 'is_user';
  static const columnIsSeller = 'is_seller';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database object
  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // If _database is null, initialize it
    _database = await _initDatabase();
    return _database;
  }

  // Open/create the database at a given path
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName); // Use join here
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create the user_table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnFirstName TEXT NOT NULL,
            $columnLastName TEXT NOT NULL,
            $columnGender TEXT NOT NULL,
            $columnCountryCode TEXT NOT NULL,
            $columnPhoneNumber TEXT NOT NULL,
            $columnIsUser INTEGER NOT NULL,
            $columnIsSeller INTEGER NOT NULL
          )
          ''');
  }

  // Insert user data
  Future<int> insert(UserData userData) async {
    Database db = await instance.database;
    return await db.insert(table, userData.toMap());
  }

  // Retrieve all user data
  Future<List<UserData>> getAllUserData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return UserData.fromMap(maps[i]);
    });
  }
}