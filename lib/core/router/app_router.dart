import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/main/presentation/pages/main_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/transactions/presentation/pages/add_transaction_page.dart';
import '../../features/budgets/presentation/pages/budgets_page.dart';
import '../../features/accounts/presentation/pages/accounts_page.dart';
import '../../features/debts/presentation/pages/debts_page.dart';
import '../../features/goals/presentation/pages/goals_page.dart';
import '../../features/recurring/presentation/pages/recurring_page.dart';
import '../../features/challenges/presentation/pages/challenges_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';

// Provider para el router principal
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    debugLogDiagnostics: true,
    routes: [
      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      
      // Autenticación
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthPage(),
      ),
      
      // Shell Route para navegación principal con BottomNavigationBar
      ShellRoute(
        builder: (context, state, child) {
          return MainPage(child: child);
        },
        routes: [
          // Dashboard
          GoRoute(
            path: '/',
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          
          // Transacciones
          GoRoute(
            path: '/transactions',
            name: 'transactions',
            builder: (context, state) => const TransactionsPage(),
            routes: [
              GoRoute(
                path: '/add',
                name: 'add-transaction',
                builder: (context, state) => const AddTransactionPage(),
              ),
              GoRoute(
                path: '/edit/:id',
                name: 'edit-transaction',
                builder: (context, state) {
                  final transactionId = int.parse(state.pathParameters['id']!);
                  return AddTransactionPage(transactionId: transactionId);
                },
              ),
            ],
          ),
          
          // Presupuestos
          GoRoute(
            path: '/budgets',
            name: 'budgets',
            builder: (context, state) => const BudgetsPage(),
          ),
          
          // Cuentas
          GoRoute(
            path: '/accounts',
            name: 'accounts',
            builder: (context, state) => const AccountsPage(),
          ),
          
          // Más opciones (sub-menú)
          GoRoute(
            path: '/more',
            name: 'more',
            builder: (context, state) => const MorePage(),
          ),
        ],
      ),
      
      // Pantallas secundarias (fullscreen)
      GoRoute(
        path: '/debts',
        name: 'debts',
        builder: (context, state) => const DebtsPage(),
      ),
      
      GoRoute(
        path: '/goals',
        name: 'goals',
        builder: (context, state) => const GoalsPage(),
      ),
      
      GoRoute(
        path: '/recurring',
        name: 'recurring',
        builder: (context, state) => const RecurringPage(),
      ),
      
      GoRoute(
        path: '/challenges',
        name: 'challenges',
        builder: (context, state) => const ChallengesPage(),
      ),
      
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    
    // Manejo de errores
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Página no encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('Ir al Inicio'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Rutas constantes para fácil acceso
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String dashboard = '/';
  static const String transactions = '/transactions';
  static const String addTransaction = '/transactions/add';
  static const String budgets = '/budgets';
  static const String accounts = '/accounts';
  static const String more = '/more';
  static const String debts = '/debts';
  static const String goals = '/goals';
  static const String recurring = '/recurring';
  static const String challenges = '/challenges';
  static const String settings = '/settings';
  
  // Métodos helper para navegación con parámetros
  static String editTransaction(int id) => '/transactions/edit/$id';
}

// Extension para navegación fácil
extension GoRouterExtension on BuildContext {
  void goToOnboarding() => go(AppRoutes.onboarding);
  void goToAuth() => go(AppRoutes.auth);
  void goToDashboard() => go(AppRoutes.dashboard);
  void goToTransactions() => go(AppRoutes.transactions);
  void goToAddTransaction() => go(AppRoutes.addTransaction);
  void goToBudgets() => go(AppRoutes.budgets);
  void goToAccounts() => go(AppRoutes.accounts);
  void goToMore() => go(AppRoutes.more);
  void goToDebts() => go(AppRoutes.debts);
  void goToGoals() => go(AppRoutes.goals);
  void goToRecurring() => go(AppRoutes.recurring);
  void goToChallenges() => go(AppRoutes.challenges);
  void goToSettings() => go(AppRoutes.settings);
  
  void goToEditTransaction(int id) => go(AppRoutes.editTransaction(id));
}