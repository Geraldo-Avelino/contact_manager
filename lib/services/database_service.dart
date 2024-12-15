// lib/services/database_service.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart'; // Verifique o caminho de importação

class DatabaseService {
  static Database? _database; // Usando tipo nulo com "?"

  // Getter para o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!; // Se já existe, retorna
    _database = await _initDB(); // Caso não, cria o banco
    return _database!;
  }

  // Inicialização do banco de dados
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath(); // Pega o caminho do banco
    final path = join(dbPath, 'contacts.db'); // Nome do banco

    // Abre o banco e cria a tabela, caso não exista
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT NOT NULL,
            email TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Pega todos os contatos
  Future<List<Contact>> getAllContacts() async {
    final db = await database; // Espera o banco
    final List<Map<String, dynamic>> maps = await db.query('contacts'); // Consulta os contatos

    // Converte os mapas para uma lista de objetos Contact
    return List.generate(maps.length, (i) => Contact.fromMap(maps[i]));
  }

  // Cria um novo contato
  Future<int> createContact(Contact contact) async {
    final db = await database; // Espera o banco
    return await db.insert('contacts', contact.toMap()); // Insere o contato no banco
  }

  // Atualiza um contato
  Future<int> updateContact(Contact contact) async {
    final db = await database; // Espera o banco
    return await db.update(
      'contacts', 
      contact.toMap(), 
      where: 'id = ?', 
      whereArgs: [contact.id],
    );
  }

  // Deleta um contato
  Future<int> deleteContact(int id) async {
    final db = await database; // Espera o banco
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
