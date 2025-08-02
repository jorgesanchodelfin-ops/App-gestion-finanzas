import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static DatabaseService get instance => _instance;
  
  Database? _database;
  
  DatabaseService._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'finanzas_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Crear todas las tablas según el esquema
    await _createTables(db);
    await _insertInitialData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Manejar migraciones de base de datos
    if (oldVersion < newVersion) {
      // Aquí se pueden agregar migraciones específicas
    }
  }

  Future<void> _createTables(Database db) async {
    // Categorías
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        icon TEXT NOT NULL,
        color TEXT NOT NULL,
        type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
        is_default BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Subcategorías
    await db.execute('''
      CREATE TABLE subcategories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE,
        UNIQUE(category_id, name)
      )
    ''');

    // Cuentas
    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL CHECK (type IN ('checking', 'savings', 'credit', 'cash', 'investment', 'debt')),
        initial_balance DECIMAL(10,2) DEFAULT 0.00,
        current_balance DECIMAL(10,2) DEFAULT 0.00,
        currency TEXT DEFAULT 'USD',
        icon TEXT NOT NULL,
        color TEXT NOT NULL,
        is_active BOOLEAN DEFAULT TRUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Transacciones
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date DATE NOT NULL,
        type TEXT NOT NULL CHECK (type IN ('income', 'expense', 'transfer')),
        category_id INTEGER,
        subcategory_id INTEGER,
        account_id INTEGER NOT NULL,
        to_account_id INTEGER,
        amount DECIMAL(10,2) NOT NULL,
        description TEXT,
        payment_method TEXT,
        is_reconciled BOOLEAN DEFAULT FALSE,
        is_recurring BOOLEAN DEFAULT FALSE,
        recurring_id INTEGER,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories (id),
        FOREIGN KEY (subcategory_id) REFERENCES subcategories (id),
        FOREIGN KEY (account_id) REFERENCES accounts (id),
        FOREIGN KEY (to_account_id) REFERENCES accounts (id),
        FOREIGN KEY (recurring_id) REFERENCES recurring_transactions (id)
      )
    ''');

    // Transacciones Recurrentes
    await db.execute('''
      CREATE TABLE recurring_transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
        category_id INTEGER,
        subcategory_id INTEGER,
        account_id INTEGER NOT NULL,
        amount DECIMAL(10,2) NOT NULL,
        description TEXT,
        payment_method TEXT,
        frequency TEXT NOT NULL CHECK (frequency IN ('daily', 'weekly', 'monthly', 'yearly')),
        start_date DATE NOT NULL,
        end_date DATE,
        next_date DATE NOT NULL,
        is_active BOOLEAN DEFAULT TRUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories (id),
        FOREIGN KEY (subcategory_id) REFERENCES subcategories (id),
        FOREIGN KEY (account_id) REFERENCES accounts (id)
      )
    ''');

    // Presupuestos
    await db.execute('''
      CREATE TABLE budgets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        year INTEGER NOT NULL,
        month INTEGER NOT NULL,
        budgeted_amount DECIMAL(10,2) NOT NULL,
        spent_amount DECIMAL(10,2) DEFAULT 0.00,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories (id),
        UNIQUE(category_id, year, month)
      )
    ''');

    // Deudas
    await db.execute('''
      CREATE TABLE debts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        original_amount DECIMAL(10,2) NOT NULL,
        current_balance DECIMAL(10,2) NOT NULL,
        interest_rate DECIMAL(5,2) NOT NULL,
        minimum_payment DECIMAL(10,2) NOT NULL,
        start_date DATE NOT NULL,
        target_date DATE,
        account_id INTEGER,
        is_active BOOLEAN DEFAULT TRUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (account_id) REFERENCES accounts (id)
      )
    ''');

    // Objetivos de Ahorro
    await db.execute('''
      CREATE TABLE savings_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        target_amount DECIMAL(10,2) NOT NULL,
        current_amount DECIMAL(10,2) DEFAULT 0.00,
        target_date DATE,
        account_id INTEGER,
        icon TEXT NOT NULL,
        color TEXT NOT NULL,
        is_completed BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (account_id) REFERENCES accounts (id)
      )
    ''');

    // Retos de Ahorro
    await db.execute('''
      CREATE TABLE savings_challenges (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL CHECK (type IN ('52_week', '365_day', 'custom')),
        target_amount DECIMAL(10,2) NOT NULL,
        current_amount DECIMAL(10,2) DEFAULT 0.00,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        frequency TEXT NOT NULL,
        is_active BOOLEAN DEFAULT TRUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Progreso de Retos
    await db.execute('''
      CREATE TABLE challenge_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        challenge_id INTEGER NOT NULL,
        week_number INTEGER,
        day_number INTEGER,
        amount DECIMAL(10,2) NOT NULL,
        is_completed BOOLEAN DEFAULT FALSE,
        completed_date DATE,
        FOREIGN KEY (challenge_id) REFERENCES savings_challenges (id) ON DELETE CASCADE
      )
    ''');

    // Configuración
    await db.execute('''
      CREATE TABLE user_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT NOT NULL UNIQUE,
        value TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Crear índices
    await db.execute('CREATE INDEX idx_transactions_date ON transactions(date)');
    await db.execute('CREATE INDEX idx_transactions_category ON transactions(category_id)');
    await db.execute('CREATE INDEX idx_transactions_account ON transactions(account_id)');
    await db.execute('CREATE INDEX idx_budgets_year_month ON budgets(year, month)');
    await db.execute('CREATE INDEX idx_recurring_next_date ON recurring_transactions(next_date)');
  }

  Future<void> _insertInitialData(Database db) async {
    // Categorías por defecto
    final categories = [
      // Gastos
      {'name': 'Alimentación', 'icon': 'restaurant', 'color': '#FF6B6B', 'type': 'expense', 'is_default': 1},
      {'name': 'Transporte', 'icon': 'directions_car', 'color': '#4ECDC4', 'type': 'expense', 'is_default': 1},
      {'name': 'Vivienda', 'icon': 'home', 'color': '#45B7D1', 'type': 'expense', 'is_default': 1},
      {'name': 'Salud', 'icon': 'local_hospital', 'color': '#96CEB4', 'type': 'expense', 'is_default': 1},
      {'name': 'Entretenimiento', 'icon': 'movie', 'color': '#FFEAA7', 'type': 'expense', 'is_default': 1},
      {'name': 'Ropa', 'icon': 'shopping_bag', 'color': '#DDA0DD', 'type': 'expense', 'is_default': 1},
      {'name': 'Educación', 'icon': 'school', 'color': '#98D8C8', 'type': 'expense', 'is_default': 1},
      {'name': 'Servicios', 'icon': 'build', 'color': '#F7DC6F', 'type': 'expense', 'is_default': 1},
      // Ingresos
      {'name': 'Salario', 'icon': 'work', 'color': '#2ECC71', 'type': 'income', 'is_default': 1},
      {'name': 'Freelance', 'icon': 'computer', 'color': '#3498DB', 'type': 'income', 'is_default': 1},
      {'name': 'Inversiones', 'icon': 'trending_up', 'color': '#9B59B6', 'type': 'income', 'is_default': 1},
      {'name': 'Otros Ingresos', 'icon': 'attach_money', 'color': '#1ABC9C', 'type': 'income', 'is_default': 1},
    ];

    for (final category in categories) {
      await db.insert('categories', category);
    }

    // Cuentas por defecto
    final accounts = [
      {'name': 'Efectivo', 'type': 'cash', 'initial_balance': 500.0, 'current_balance': 500.0, 'icon': 'account_balance_wallet', 'color': '#4CAF50'},
      {'name': 'Cuenta Corriente', 'type': 'checking', 'initial_balance': 2000.0, 'current_balance': 2000.0, 'icon': 'account_balance', 'color': '#2196F3'},
      {'name': 'Ahorro', 'type': 'savings', 'initial_balance': 5000.0, 'current_balance': 5000.0, 'icon': 'savings', 'color': '#FF9800'},
    ];

    for (final account in accounts) {
      await db.insert('accounts', account);
    }

    // Configuración por defecto
    final settings = [
      {'key': 'currency', 'value': 'USD'},
      {'key': 'currency_symbol', 'value': '\$'},
      {'key': 'theme_mode', 'value': 'system'},
      {'key': 'biometric_enabled', 'value': 'false'},
      {'key': 'backup_enabled', 'value': 'false'},
      {'key': 'notification_enabled', 'value': 'true'},
    ];

    for (final setting in settings) {
      await db.insert('user_settings', setting);
    }
  }

  Future<void> initialize() async {
    await database;
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  // Métodos helper genéricos
  Future<List<Map<String, dynamic>>> query(String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  Future<int> update(String table, Map<String, dynamic> values, {
    required String where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, {
    required String where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  Future<int> rawInsert(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawInsert(sql, arguments);
  }

  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawUpdate(sql, arguments);
  }

  Future<int> rawDelete(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawDelete(sql, arguments);
  }
}