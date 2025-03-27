import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/users.dart';

class DatabaseServices {
  final databaseName = "app.db";

  // Tables
  // To store user's personal data
  String users = '''
    CREATE TABLE users (
      User_Code TEXT PRIMARY KEY,
      User_Display_Name TEXT,
      Email TEXT,
      User_Employee_Code TEXT,
      Company_Code TEXT
    )
  ''';

  // To store user's location data
  String userLocations = '''
    CREATE TABLE userLocations (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      User_Code TEXT,
      User_Location TEXT,
      FOREIGN KEY (User_Code) REFERENCES users (User_Code) ON DELETE CASCADE
    )
  ''';

  // To store user's permission data
  String userPermissions = '''
    CREATE TABLE userPermissions (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      User_Code TEXT,
      User_Permission TEXT,
      FOREIGN KEY (User_Code) REFERENCES users (User_Code) ON DELETE CASCADE
    )
  ''';

  // Connection
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // Creating tables
      await db.execute(users);
      await db.execute(userLocations);
      await db.execute(userPermissions);
    });
  }

  Future<void> storeUserData(Users user) async {
    final Database db = await initDB();

    await db.insert(
      'users',
      {
        'User_Code': user.userCode,
        'User_Display_Name': user.userDisplayName,
        'Email': user.email,
        'User_Employee_Code': user.userEmployeeCode,
        'Company_Code': user.companyCode
      },
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Replace if the entry already exists
    );

    if (user.userLocations.isNotEmpty) {
      for (String location in user.userLocations) {
        // Check if the location already exists for the user
        final existingLocation = await db.query(
          'userLocations',
          where: 'User_Code = ? AND User_Location = ?',
          whereArgs: [user.userCode, location],
        );

        // Insert the location if it does not exist
        if (existingLocation.isEmpty) {
          await db.insert(
            'userLocations',
            {
              'User_Code': user.userCode,
              'User_Location': location,
            },
          );
        }
      }
    } else {
      // Insert null for the given user code if the list is empty
      await db.insert(
        'userLocations',
        {
          'User_Code': user.userCode,
          'User_Location': null,
        },
        conflictAlgorithm:
            ConflictAlgorithm.ignore, // Avoid inserting duplicates
      );
    }

    if (user.userPermissions.isNotEmpty) {
      for (String permission in user.userPermissions) {
        final existingPermission = await db.query(
          'userPermissions',
          where: 'User_Code = ? AND User_Permission = ?',
          whereArgs: [user.userCode, permission],
        );

        if (existingPermission.isEmpty) {
          await db.insert(
            'userPermissions',
            {
              'User_Code': user.userCode,
              'User_Permission': permission,
            },
          );
        }
      }
    } else {
      await db.insert(
        'userPermissions',
        {
          'User_Code': user.userCode,
          'User_Permission': null,
        },
        conflictAlgorithm:
            ConflictAlgorithm.ignore,
      );
    }
  }
}
