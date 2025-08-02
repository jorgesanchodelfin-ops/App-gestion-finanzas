-- Esquema de Base de Datos para Aplicación Financiera Personal
-- SQLite Database Schema

-- Tabla de Categorías
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    icon TEXT NOT NULL,
    color TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
    is_default BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Subcategorías
CREATE TABLE subcategories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE,
    UNIQUE(category_id, name)
);

-- Tabla de Cuentas Financieras
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
);

-- Tabla de Transacciones
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('income', 'expense', 'transfer')),
    category_id INTEGER,
    subcategory_id INTEGER,
    account_id INTEGER NOT NULL,
    to_account_id INTEGER, -- Para transferencias
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
);

-- Tabla de Transacciones Recurrentes
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
);

-- Tabla de Presupuestos
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
);

-- Tabla de Deudas
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
);

-- Tabla de Objetivos de Ahorro
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
);

-- Tabla de Retos de Ahorro
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
);

-- Tabla de Progreso de Retos
CREATE TABLE challenge_progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    challenge_id INTEGER NOT NULL,
    week_number INTEGER,
    day_number INTEGER,
    amount DECIMAL(10,2) NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_date DATE,
    FOREIGN KEY (challenge_id) REFERENCES savings_challenges (id) ON DELETE CASCADE
);

-- Tabla de Configuración de Usuario
CREATE TABLE user_settings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key TEXT NOT NULL UNIQUE,
    value TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Índices para optimizar consultas
CREATE INDEX idx_transactions_date ON transactions(date);
CREATE INDEX idx_transactions_category ON transactions(category_id);
CREATE INDEX idx_transactions_account ON transactions(account_id);
CREATE INDEX idx_budgets_year_month ON budgets(year, month);
CREATE INDEX idx_recurring_next_date ON recurring_transactions(next_date);

-- Datos iniciales - Categorías por defecto
INSERT INTO categories (name, icon, color, type, is_default) VALUES
-- Gastos
('Alimentación', 'restaurant', '#FF6B6B', 'expense', TRUE),
('Transporte', 'directions_car', '#4ECDC4', 'expense', TRUE),
('Vivienda', 'home', '#45B7D1', 'expense', TRUE),
('Salud', 'local_hospital', '#96CEB4', 'expense', TRUE),
('Entretenimiento', 'movie', '#FFEAA7', 'expense', TRUE),
('Ropa', 'shopping_bag', '#DDA0DD', 'expense', TRUE),
('Educación', 'school', '#98D8C8', 'expense', TRUE),
('Servicios', 'build', '#F7DC6F', 'expense', TRUE),
-- Ingresos
('Salario', 'work', '#2ECC71', 'income', TRUE),
('Freelance', 'computer', '#3498DB', 'income', TRUE),
('Inversiones', 'trending_up', '#9B59B6', 'income', TRUE),
('Otros Ingresos', 'attach_money', '#1ABC9C', 'income', TRUE);

-- Configuración inicial
INSERT INTO user_settings (key, value) VALUES
('currency', 'USD'),
('currency_symbol', '$'),
('theme_mode', 'system'),
('biometric_enabled', 'false'),
('backup_enabled', 'false'),
('notification_enabled', 'true');