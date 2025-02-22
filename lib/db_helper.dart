import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Patrón singleton para usar una sola instancia de la base de datos
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Obtiene la ruta donde se guardarán las bases de datos en el dispositivo
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'user_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Este método se llama cuando se crea la base de datos por primera vez
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE users(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         usuario TEXT NOT NULL,
         password TEXT NOT NULL
      )
      '''
    );

    // Insertar el usuario por defecto (por ejemplo, el contenido del JSON)
    await db.insert('users', {'usuario': 'admin', 'password': '12345'});
  }

  // Método para obtener el usuario según el nombre (usuario)
  Future<Map<String, dynamic>?> getUser(String usuario) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'usuario = ?',
      whereArgs: [usuario],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  // Método para actualizar las credenciales del usuario
  Future<int> updateUser(String usuario, String newUsuario, String newPassword) async {
    final db = await database;
    return await db.update(
      'users',
      {'usuario': newUsuario, 'password': newPassword},
      where: 'usuario = ?',
      whereArgs: [usuario],
    );
  }
}
