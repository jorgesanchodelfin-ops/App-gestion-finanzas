import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  
  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Rutas de navegación principal
  static const List<String> _routes = [
    '/',
    '/transactions',
    '/budgets',
    '/accounts',
    '/more',
  ];

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determinar el índice actual basado en la ruta
    final String location = GoRouterState.of(context).uri.path;
    
    if (location.startsWith('/transactions')) {
      _currentIndex = 1;
    } else if (location.startsWith('/budgets')) {
      _currentIndex = 2;
    } else if (location.startsWith('/accounts')) {
      _currentIndex = 3;
    } else if (location.startsWith('/more')) {
      _currentIndex = 4;
    } else {
      _currentIndex = 0;
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.viewDashboard),
              activeIcon: Icon(MdiIcons.viewDashboard),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.swapHorizontal),
              activeIcon: Icon(MdiIcons.swapHorizontal),
              label: 'Transacciones',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.walletOutline),
              activeIcon: Icon(MdiIcons.wallet),
              label: 'Presupuesto',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.bankOutline),
              activeIcon: Icon(MdiIcons.bank),
              label: 'Cuentas',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.dotsHorizontal),
              activeIcon: Icon(MdiIcons.dotsHorizontal),
              label: 'Más',
            ),
          ],
        ),
      ),
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () => context.go('/transactions/add'),
              tooltip: 'Agregar Transacción',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

// Página de "Más opciones"
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Más'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Gestión Financiera'),
          _buildMenuItem(
            context,
            icon: MdiIcons.creditCardOutline,
            title: 'Gestión de Deudas',
            subtitle: 'Administra tus deudas y estrategias de pago',
            onTap: () => context.go('/debts'),
          ),
          _buildMenuItem(
            context,
            icon: MdiIcons.targetVariant,
            title: 'Objetivos de Ahorro',
            subtitle: 'Define y sigue tus metas financieras',
            onTap: () => context.go('/goals'),
          ),
          _buildMenuItem(
            context,
            icon: MdiIcons.refresh,
            title: 'Transacciones Recurrentes',
            subtitle: 'Configura ingresos y gastos automáticos',
            onTap: () => context.go('/recurring'),
          ),
          _buildMenuItem(
            context,
            icon: MdiIcons.trophy,
            title: 'Retos de Ahorro',
            subtitle: 'Participa en desafíos gamificados',
            onTap: () => context.go('/challenges'),
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Configuración'),
          _buildMenuItem(
            context,
            icon: MdiIcons.cog,
            title: 'Configuración',
            subtitle: 'Ajustes de la aplicación',
            onTap: () => context.go('/settings'),
          ),
          _buildMenuItem(
            context,
            icon: MdiIcons.fileExport,
            title: 'Exportar Datos',
            subtitle: 'Exporta tus datos a CSV/Excel',
            onTap: () => _showExportDialog(context),
          ),
          _buildMenuItem(
            context,
            icon: MdiIcons.backup,
            title: 'Copia de Seguridad',
            subtitle: 'Respalda tus datos en la nube',
            onTap: () => _showBackupDialog(context),
          ),
          _buildMenuItem(
            context,
            icon: MdiIcons.informationOutline,
            title: 'Acerca de',
            subtitle: 'Información de la aplicación',
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportar Datos'),
        content: const Text('¿Qué período deseas exportar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar exportación
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exportando datos...')),
              );
            },
            child: const Text('Este Mes'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Copia de Seguridad'),
        content: const Text('¿Deseas crear una copia de seguridad de tus datos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar backup
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Creando respaldo...')),
              );
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Finanzas App',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 48),
      children: [
        const Text('Aplicación de gestión financiera personal moderna y amigable.'),
        const SizedBox(height: 16),
        const Text('Desarrollada con Flutter y diseñada para ser intuitiva y completa.'),
      ],
    );
  }
}