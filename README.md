# 💰 Finanzas App - Gestión Financiera Personal

Una aplicación móvil moderna y amigable para la gestión financiera personal y de pareja, desarrollada en Flutter. Diseñada para reemplazar y mejorar la funcionalidad de las hojas de cálculo tradicionales con una interfaz intuitiva y visual.

## 🌟 Características Principales

### 📊 Dashboard Inteligente
- **Resumen financiero del mes**: Ingresos, gastos, ahorro y patrimonio neto
- **Gráficos interactivos**: 
  - Distribución de gastos por categoría (gráfico circular)
  - Comparación presupuesto vs real (gráfico de barras)
  - Evolución del patrimonio (gráfico de líneas)
- **Accesos rápidos** para transacciones comunes
- **Transacciones recientes** con vista previa

### 💳 Gestión de Transacciones
- **Formulario intuitivo** paso a paso
- **Categorización automática** con íconos personalizados
- **Validación inteligente** de campos
- **Soporte para transferencias** entre cuentas
- **Marcado de reconciliación**

### 📈 Presupuesto Mensual y Anual
- **Configuración por categoría** mes a mes
- **Alertas visuales** al exceder presupuestos
- **Comparaciones en tiempo real** vs gastos reales
- **Gráficos de seguimiento** automáticos

### 🏦 Gestión de Cuentas
- **Múltiples tipos de cuenta**: Corriente, ahorro, efectivo, crédito, inversión
- **Saldos calculados automáticamente**
- **Historial de movimientos**
- **Códigos de color** y iconos personalizados

### 💸 Gestión de Deudas
- **Estrategias de pago**: Método bola de nieve y avalancha
- **Cálculo de intereses** y fechas de finalización
- **Progreso visual** del pago de deudas
- **Recordatorios** de pagos

### 🎯 Objetivos de Ahorro
- **Metas personalizables** con fechas límite
- **Cálculo automático** de aportaciones necesarias
- **Progreso visual** con barras y donuts
- **Vinculación** con cuentas específicas

### 🔄 Transacciones Recurrentes
- **Automatización** de ingresos y gastos fijos
- **Múltiples frecuencias**: Diaria, semanal, mensual, anual
- **Gestión de fechas** de inicio y fin

### 🏆 Retos de Ahorro Gamificados
- **Reto de 52 semanas**: Ahorro progresivo
- **Reto de 365 días**: Pequeños ahorros diarios
- **Retos personalizados** definidos por el usuario
- **Seguimiento visual** tipo calendario

## 🎨 Diseño y Experiencia de Usuario

### Material Design 3
- **Interfaz moderna** con colores suaves y armoniosos
- **Navegación intuitiva** con tab bar inferior
- **Animaciones fluidas** y transiciones naturales
- **Compatibilidad** con modo claro y oscuro

### Accesibilidad
- **Iconos personalizados** para cada categoría
- **Código de colores** consistente
- **Tipografía clara** con Google Fonts (Inter)
- **Validación visual** de formularios

## 🏗️ Arquitectura Técnica

### Stack Tecnológico
- **Frontend**: Flutter 3.10+ con Dart 3.0+
- **Estado**: Riverpod para gestión reactiva
- **Base de datos**: SQLite local con sqflite
- **Navegación**: GoRouter para rutas declarativas
- **Gráficos**: FL Chart y Syncfusion Charts
- **UI**: Material Design 3 components

### Estructura del Proyecto
```
lib/
├── core/
│   ├── router/          # Configuración de rutas
│   ├── theme/           # Temas y estilos
│   └── services/        # Servicios base (BD, etc.)
├── features/
│   ├── dashboard/       # Pantalla principal
│   ├── transactions/    # Gestión de transacciones
│   ├── budgets/         # Presupuestos
│   ├── accounts/        # Cuentas financieras
│   ├── debts/           # Gestión de deudas
│   ├── goals/           # Objetivos de ahorro
│   ├── recurring/       # Transacciones recurrentes
│   ├── challenges/      # Retos de ahorro
│   └── settings/        # Configuración
└── main.dart
```

### Base de Datos
La aplicación utiliza SQLite con las siguientes tablas principales:
- `categories` - Categorías de ingresos y gastos
- `accounts` - Cuentas financieras del usuario
- `transactions` - Todas las transacciones
- `budgets` - Presupuestos por categoría/mes
- `debts` - Gestión de deudas
- `savings_goals` - Objetivos de ahorro
- `recurring_transactions` - Transacciones automáticas
- `savings_challenges` - Retos de ahorro

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK 3.10.0 o superior
- Dart SDK 3.0.0 o superior
- Android Studio / VS Code
- Dispositivo Android/iOS o emulador

### Pasos de Instalación

#### 🚀 Opción 1: Script Automático (Recomendado)

**Linux/macOS:**
```bash
# Hacer ejecutable el script
chmod +x run_app.sh
# Ejecutar
./run_app.sh
```

**Windows:**
```cmd
# Ejecutar directamente
run_app.bat
```

#### 📖 Opción 2: Manual

1. **Verificar Flutter**
   ```bash
   flutter doctor
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Crear directorios de assets**
   ```bash
   mkdir -p assets/{images,icons,animations,fonts}
   ```

4. **Verificar dispositivos**
   ```bash
   flutter devices
   ```

5. **Ejecutar la aplicación**
   ```bash
   # Modo debug (desarrollo)
   flutter run
   
   # Modo release (más rápido)
   flutter run --release
   
   # En navegador web
   flutter run -d chrome
   ```

### Configuración Inicial
La aplicación se inicializa con:
- Categorías predefinidas para gastos e ingresos
- Cuentas de ejemplo (Efectivo, Cuenta Corriente, Ahorro)
- Configuración por defecto del usuario

## 📱 Funcionalidades Adicionales

### Seguridad
- **Autenticación biométrica** (huella dactilar/facial)
- **PIN de seguridad** para acceso
- **Cifrado de datos** sensibles

### Respaldo y Exportación
- **Exportación a CSV/Excel** por períodos
- **Copia de seguridad** en Google Drive
- **Sincronización** entre dispositivos

### Notificaciones
- **Recordatorios** de presupuestos excedidos
- **Alertas** de pagos de deudas
- **Notificaciones** de retos de ahorro

## 🔮 Mejoras y Funciones Adicionales Sugeridas

### 🤖 Inteligencia Artificial
1. **Categorización Automática**: IA que aprende de patrones de gasto para categorizar automáticamente nuevas transacciones
2. **Predicción de Gastos**: Análisis predictivo para anticipar gastos futuros basado en históricos
3. **Recomendaciones Personalizadas**: Sugerencias de ahorro y optimización financiera

### 📊 Analytics Avanzados
4. **Reportes Inteligentes**: Generación automática de insights financieros mensuales
5. **Comparaciones Temporales**: Análisis año contra año, trimestre contra trimestre
6. **Benchmarking**: Comparación anónima con usuarios similares

### 🌐 Conectividad
7. **Integración Bancaria**: Conexión con APIs bancarias para importación automática
8. **Sincronización en la Nube**: Backend con sincronización multi-dispositivo
9. **Modo Colaborativo**: Gestión financiera compartida para parejas

### 💡 Características Avanzadas
10. **Planificador de Jubilación**: Calculadora de ahorro para retiro
11. **Simulador de Inversiones**: Herramientas básicas de análisis de inversión
12. **Gestión de Impuestos**: Categorización y tracking para declaraciones
13. **Modo Vacaciones**: Presupuesto especial para viajes con conversión de monedas

### 🎮 Gamificación Extendida
14. **Sistema de Logros**: Badges por alcanzar metas financieras
15. **Competencias**: Retos entre amigos/familia
16. **Niveles de Usuario**: Progresión basada en hábitos financieros saludables

### 🔄 Automatización
17. **Reglas de Negocio**: Automatización compleja de transacciones
18. **Smart Budgeting**: Ajuste automático de presupuestos basado en patrones
19. **Alertas Inteligentes**: Notificaciones contextuales y personalizadas

### 📈 Herramientas Profesionales
20. **Flujo de Caja**: Proyecciones de efectivo a futuro
21. **Ratios Financieros**: Cálculo automático de indicadores clave
22. **Portfolio Tracking**: Seguimiento básico de inversiones

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📞 Soporte

Para soporte técnico o preguntas:
- 📧 Email: soporte@finanzasapp.com
- 🐛 Issues: GitHub Issues
- 📖 Documentación: Wiki del proyecto

---

*Desarrollado con ❤️ para hacer las finanzas personales más simples y accesibles para todos.*
