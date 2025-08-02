# 🎨 Diseño UI/UX - Finanzas App

## 📱 Flujo de Navegación

### Estructura Principal
```
┌─────────────────────────────────────────────────────────────┐
│                     ONBOARDING                             │
│                         ↓                                  │
│                   AUTENTICACIÓN                            │
│                         ↓                                  │
│                  APLICACIÓN PRINCIPAL                      │
│                                                             │
│  ┌─────────┬─────────┬─────────┬─────────┬─────────┐      │
│  │ INICIO  │ TRANS.  │ PRESU.  │ CUENTAS │  MÁS    │      │
│  └─────────┴─────────┴─────────┴─────────┴─────────┘      │
│                                                             │
│  Pantallas Secundarias (desde MÁS):                       │
│  • Gestión de Deudas                                       │
│  • Objetivos de Ahorro                                     │
│  • Transacciones Recurrentes                               │
│  • Retos de Ahorro                                         │
│  • Configuración                                           │
└─────────────────────────────────────────────────────────────┘
```

## 🏠 Dashboard (Pantalla Principal)

### Layout Visual
```
┌─────────────────────────────────────────────────────────────┐
│  ╔═══════════════════════════════════════════════════════╗  │
│  ║                HEADER GRADIENTE                       ║  │
│  ║  Buenos días, Usuario                    🔔 ⚙️        ║  │
│  ║  DICIEMBRE 2024                                       ║  │
│  ╚═══════════════════════════════════════════════════════╝  │
│                                                             │
│  ┌─────────────┬─────────────┐ ┌─────────────┬─────────────┐│
│  │📈 Ingresos  │📉 Gastos    │ │🐷 Ahorro    │💎 Patrimonio││
│  │$3,500.00    │$2,850.00    │ │$650.00      │$45,200.00   ││
│  └─────────────┴─────────────┘ └─────────────┴─────────────┘│
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │           📊 GASTOS POR CATEGORÍA                     │  │
│  │                 (Gráfico Circular)                    │  │
│  │    🍔35%    🚗25%    🏠20%    ⚡20%                   │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │           📊 PRESUPUESTO VS REAL                      │  │
│  │                (Gráfico de Barras)                    │  │
│  │   ████████████████████████████████████████████████    │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │           📈 EVOLUCIÓN DEL PATRIMONIO                 │  │
│  │                (Gráfico de Líneas)                    │  │
│  │   ╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲╱╲                 │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌─────────────┬─────────────┬─────────────┐                │
│  │➖ Gasto     │➕ Ingreso   │📊 Presup.   │                │
│  └─────────────┴─────────────┴─────────────┘                │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │           📋 TRANSACCIONES RECIENTES                  │  │
│  │  🛒 Supermercado        Hoy         -$85.50          │  │
│  │  💼 Salario            1 día       +$3,500.00        │  │
│  │  ⛽ Gasolina           2 días        -$45.00          │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│                            ➕ FAB                           │
└─────────────────────────────────────────────────────────────┘
```

## 💳 Pantalla de Transacciones

### Formulario Paso a Paso
```
┌─────────────────────────────────────────────────────────────┐
│  ← AGREGAR TRANSACCIÓN                                      │
│                                                             │
│  ┌─●─○─○─○─┐ Paso 1 de 4                                  │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                   TIPO                                  ││
│  │                                                         ││
│  │  ┌─────────┐        ┌─────────┐                        ││
│  │  │   💰    │        │   💸    │                        ││
│  │  │ INGRESO │        │  GASTO  │                        ││
│  │  └─────────┘        └─────────┘                        ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                  CATEGORÍA                              ││
│  │                                                         ││
│  │  🍔 Alimentación    🚗 Transporte    🏠 Vivienda       ││
│  │  🏥 Salud          🎬 Entretenim.    👕 Ropa          ││
│  │  📚 Educación      ⚡ Servicios      ➕ Agregar        ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                   MONTO                                 ││
│  │  ┌─────────────────────────────────────────────────┐   ││
│  │  │                $0.00                            │   ││
│  │  └─────────────────────────────────────────────────┘   ││
│  │                                                         ││
│  │  [1] [2] [3]                                           ││
│  │  [4] [5] [6]                                           ││
│  │  [7] [8] [9]                                           ││
│  │  [.] [0] [⌫]                                           ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│                    [CONTINUAR]                              │
└─────────────────────────────────────────────────────────────┘
```

## 📊 Pantalla de Presupuestos

### Vista Mensual
```
┌─────────────────────────────────────────────────────────────┐
│  ← PRESUPUESTOS                            📅 Dic 2024     │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           📊 RESUMEN DEL MES                            ││
│  │                                                         ││
│  │  Presupuestado: $2,800.00                              ││
│  │  Gastado:       $2,650.00  ✅ -$150.00                 ││
│  │  Restante:      $150.00     (5% del total)             ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           💰 POR CATEGORÍA                              ││
│  │                                                         ││
│  │  🍔 Alimentación                              85% ⚠️   ││
│  │  ████████████████████████████████████████████████      ││
│  │  $850 / $1,000                                         ││
│  │                                                         ││
│  │  🚗 Transporte                                72% ✅   ││
│  │  ████████████████████████████████████████              ││
│  │  $360 / $500                                           ││
│  │                                                         ││
│  │  🏠 Vivienda                                  45% ✅   ││
│  │  ████████████████████████                              ││
│  │  $450 / $1,000                                         ││
│  │                                                         ││
│  │  🎬 Entretenimiento                           90% 🚨   ││
│  │  ████████████████████████████████████████████████████  ││
│  │  $180 / $200                                           ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│                     [AJUSTAR PRESUPUESTO]                   │
└─────────────────────────────────────────────────────────────┘
```

## 🏦 Pantalla de Cuentas

### Lista de Cuentas
```
┌─────────────────────────────────────────────────────────────┐
│  ← CUENTAS                                        ➕        │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           💰 RESUMEN TOTAL                              ││
│  │              $7,500.00                                  ││
│  │        Patrimonio Neto Total                            ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  💵 Efectivo                                    $500.00 ││
│  │     Dinero en cartera                                   ││
│  │                                         ────────────── ││
│  │                                                         ││
│  │  🏦 Cuenta Corriente                          $2,000.00 ││
│  │     Banco Nacional                                      ││
│  │     **** 1234                              ────────────││
│  │                                                         ││
│  │  💰 Cuenta de Ahorro                          $5,000.00 ││
│  │     Banco Nacional                                      ││
│  │     **** 5678                              ────────────││
│  │                                                         ││
│  │  💳 Tarjeta de Crédito                       -$200.00  ││
│  │     Límite: $3,000                                     ││
│  │     Disponible: $2,800                     ────────────││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           📊 DISTRIBUCIÓN                               ││
│  │                                                         ││
│  │         🍩 Gráfico Donut por tipo de cuenta             ││
│  │           Efectivo 7% | Corriente 27%                  ││
│  │           Ahorro 66%                                    ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

## 🎯 Pantalla de Objetivos

### Lista de Metas
```
┌─────────────────────────────────────────────────────────────┐
│  ← OBJETIVOS DE AHORRO                            ➕        │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  🏖️ Vacaciones 2025                           75% ✅   ││
│  │     Meta: $3,000  |  Ahorrado: $2,250                  ││
│  │     ████████████████████████████████████████            ││
│  │     Faltan $750 | Fecha: Jun 2025                      ││
│  │     Sugerido: $125/mes                                  ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  🚗 Auto Nuevo                                 25% 🔄   ││
│  │     Meta: $20,000  |  Ahorrado: $5,000                 ││
│  │     ████████████                                        ││
│  │     Faltan $15,000 | Fecha: Dic 2026                   ││
│  │     Sugerido: $625/mes                                  ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  🏠 Enganche Casa                               5% 📈   ││
│  │     Meta: $50,000  |  Ahorrado: $2,500                 ││
│  │     ████                                                ││
│  │     Faltan $47,500 | Fecha: Dic 2029                   ││
│  │     Sugerido: $792/mes                                  ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           📊 PROGRESO GENERAL                           ││
│  │                                                         ││
│  │     Total Objetivos: $73,000                           ││
│  │     Total Ahorrado:  $9,750  (13%)                     ││
│  │                                                         ││
│  │     📈 Gráfico de progreso combinado                   ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

## 🏆 Pantalla de Retos

### Reto 52 Semanas
```
┌─────────────────────────────────────────────────────────────┐
│  ← RETO DE 52 SEMANAS                             🏆        │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           🎯 RETO ACTIVO                                ││
│  │                                                         ││
│  │     Semana 47 de 52                           90% ✅    ││
│  │     ████████████████████████████████████████████████    ││
│  │                                                         ││
│  │     💰 Ahorrado: $1,128                                ││
│  │     🎯 Meta Total: $1,378                              ││
│  │     📅 Faltan: 5 semanas                               ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           📅 CALENDARIO                                 ││
│  │                                                         ││
│  │   S1✅ S2✅ S3✅ S4✅ S5✅ S6✅ S7✅                   ││
│  │   S8✅ S9✅ S10✅ S11✅ S12✅ S13✅ S14✅              ││
│  │   S15✅ S16✅ S17✅ S18✅ S19✅ S20✅ S21✅             ││
│  │   ...                                                   ││
│  │   S43✅ S44✅ S45✅ S46✅ S47🔄 S48○ S49○             ││
│  │   S50○ S51○ S52○                                       ││
│  │                                                         ││
│  │         Esta semana: $47 💰                             ││
│  │         [MARCAR COMO COMPLETADA]                        ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │           🏅 ESTADÍSTICAS                               ││
│  │                                                         ││
│  │     Semanas completadas: 46/52                         ││
│  │     Racha actual: 46 semanas                           ││
│  │     Promedio semanal: $24.52                           ││
│  │     Fecha estimada de finalización: 15 Enero 2025      ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

## 🎨 Sistema de Colores

### Paleta Principal
- **Primario**: `#6C63FF` (Púrpura vibrante)
- **Secundario**: `#2ECC71` (Verde éxito)
- **Error**: `#FF6B6B` (Rojo suave)
- **Warning**: `#FFA726` (Naranja cálido)
- **Info**: `#42A5F5` (Azul información)

### Colores por Categoría
- **Ingresos**: `#2ECC71` (Verde)
- **Gastos**: `#E74C3C` (Rojo)
- **Alimentación**: `#FF6B6B` (Rojo coral)
- **Transporte**: `#4ECDC4` (Turquesa)
- **Vivienda**: `#45B7D1` (Azul cielo)
- **Salud**: `#96CEB4` (Verde menta)
- **Entretenimiento**: `#FFEAA7` (Amarillo cálido)

### Modo Oscuro
- **Superficie**: `#1A1B23` (Gris oscuro)
- **Tarjetas**: `#252730` (Gris medio)
- **Texto**: `#E8E8E8` (Blanco suave)

## 🖼️ Iconografía

### Categorías
- 🍔 Alimentación - `restaurant`
- 🚗 Transporte - `directions_car`
- 🏠 Vivienda - `home`
- 🏥 Salud - `local_hospital`
- 🎬 Entretenimiento - `movie`
- 👕 Ropa - `shopping_bag`
- 📚 Educación - `school`
- ⚡ Servicios - `build`

### Tipos de Cuenta
- 💵 Efectivo - `account_balance_wallet`
- 🏦 Corriente - `account_balance`
- 💰 Ahorro - `savings`
- 💳 Crédito - `credit_card`
- 📈 Inversión - `trending_up`

## 📐 Espaciado y Tipografía

### Espaciado
- **Pequeño**: 8px
- **Medio**: 16px
- **Grande**: 24px
- **Extra Grande**: 32px

### Tipografía (Google Fonts - Inter)
- **Display Large**: 57px, Weight 400
- **Headline Large**: 32px, Weight 600
- **Title Large**: 22px, Weight 600
- **Body Large**: 16px, Weight 400
- **Body Medium**: 14px, Weight 400
- **Label Large**: 14px, Weight 500

## 📱 Responsividad

### Breakpoints
- **Teléfono**: < 600px
- **Tablet**: 600px - 1024px
- **Desktop**: > 1024px

### Adaptaciones
- Cards apiladas en móvil, lado a lado en tablet
- Gráficos escalables según el ancho de pantalla
- Navegación inferior fija en móvil
- Sidebar colapsable en desktop

## ⚡ Animaciones y Transiciones

### Duración
- **Rápida**: 150ms (hover, focus)
- **Normal**: 300ms (navegación, modal)
- **Lenta**: 500ms (gráficos, datos)

### Easing
- `cubic-bezier(0.4, 0.0, 0.2, 1)` - Material Design Standard
- `cubic-bezier(0.0, 0.0, 0.2, 1)` - Decelerate
- `cubic-bezier(0.4, 0.0, 1, 1)` - Accelerate

### Animaciones Específicas
- **Entrada de tarjetas**: Slide up + fade in
- **Cambio de pantalla**: Shared element transition
- **Carga de gráficos**: Progressive drawing
- **Éxito**: Escala + bounce

---

*Este documento describe las interfaces principales. Cada pantalla mantiene consistencia con el sistema de diseño Material 3 y prioriza la usabilidad y accesibilidad.*