# 🔍 Diagnóstico y Solución de Problemas

## ⚡ Ejecución Rápida

### 1. Primera vez ejecutando la app
```bash
# Script automático (Linux/macOS)
./run_app.sh

# Script automático (Windows)
run_app.bat

# Manual básico
flutter pub get && flutter run
```

### 2. Ya tienes Flutter configurado
```bash
flutter run
```

## 🐛 Problemas Comunes y Soluciones

### ❌ "flutter: command not found"
**Problema**: Flutter no está instalado o no está en el PATH

**Solución**:
1. Instalar Flutter: https://docs.flutter.dev/get-started/install
2. Agregar al PATH:
   ```bash
   # Linux/macOS
   export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
   
   # Windows (en Variables de Entorno)
   PATH = C:\src\flutter\bin
   ```

### ❌ "No devices found"
**Problema**: No hay dispositivos conectados

**Soluciones**:
1. **Emulador Android**:
   ```bash
   # Listar emuladores
   flutter emulators
   # Lanzar emulador
   flutter emulators --launch <emulator_id>
   ```

2. **Dispositivo físico Android**:
   - Habilitar "Opciones de desarrollador"
   - Activar "Depuración USB"
   - Conectar por USB

3. **Navegador web**:
   ```bash
   flutter config --enable-web
   flutter run -d chrome
   ```

### ❌ "Pub get failed"
**Problema**: Error al instalar dependencias

**Solución**:
```bash
# Limpiar cache
flutter clean
flutter pub cache clean

# Re-instalar
flutter pub get

# Si persiste, verificar conectividad a internet
```

### ❌ "Android SDK not found"
**Problema**: Android SDK no configurado

**Solución**:
1. Abrir Android Studio
2. Tools > SDK Manager
3. Instalar Android SDK Platform-Tools
4. Configurar variables de entorno

### ❌ "CocoaPods not installed" (macOS)
**Problema**: CocoaPods faltante para iOS

**Solución**:
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
```

### ❌ Errores de compilación
**Problema**: Errores durante la compilación

**Solución**:
```bash
# Limpiar proyecto
flutter clean
flutter pub get

# Regenerar archivos
flutter packages pub run build_runner clean
flutter packages pub run build_runner build

# Actualizar dependencias
flutter pub upgrade
```

## 📊 Comandos de Diagnóstico

### Verificar estado general
```bash
flutter doctor -v
```

### Ver dispositivos disponibles
```bash
flutter devices
```

### Verificar dependencias
```bash
flutter pub deps
```

### Analizar proyecto
```bash
flutter analyze
```

### Ver logs en tiempo real
```bash
flutter logs
```

## 🎯 Modos de Ejecución

### Desarrollo (recomendado)
```bash
flutter run
```
- Hot reload activado
- Debugging habilitado
- Herramientas de desarrollo disponibles

### Release (producción)
```bash
flutter run --release
```
- Optimizado para rendimiento
- Sin debugging
- Más rápido

### Profile (análisis)
```bash
flutter run --profile
```
- Para análisis de rendimiento
- Algunas optimizaciones activadas

### Web
```bash
flutter run -d chrome
```
- Ejecuta en navegador
- Útil para pruebas rápidas

## 🔧 Configuración Avanzada

### Variables de entorno útiles
```bash
# Desactivar analytics (opcional)
export FLUTTER_SUPPRESS_ANALYTICS=true

# Configurar proxy (si es necesario)
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080
```

### Optimizar rendimiento
```bash
# Pre-compilar assets
flutter precache

# Usar modo verboso para debugging
flutter run -v
```

## ✅ Verificación Final

Si todo funciona correctamente deberías ver:

1. ✅ `flutter doctor` sin errores críticos
2. ✅ Al menos un dispositivo disponible en `flutter devices`
3. ✅ `flutter pub get` se ejecuta sin errores
4. ✅ `flutter run` inicia la aplicación

### Estado esperado de la app:
- Pantalla de onboarding inicial
- Dashboard con tarjetas de resumen
- Navegación inferior funcional
- Gráficos placeholder visibles
- Transiciones suaves

## 🆘 ¿Aún no funciona?

1. **Compartir diagnóstico**:
   ```bash
   flutter doctor -v > diagnostico.txt
   ```

2. **Revisar logs completos**:
   ```bash
   flutter run -v > logs.txt 2>&1
   ```

3. **Verificar versiones**:
   - Flutter: 3.10.0+
   - Dart: 3.0.0+
   - Android SDK: 30+

4. **Recursos adicionales**:
   - [Flutter Doctor](https://docs.flutter.dev/reference/flutter-cli#flutter-doctor)
   - [Troubleshooting](https://docs.flutter.dev/testing/debugging)
   - [Platform Setup](https://docs.flutter.dev/get-started/install)

---

*💡 Tip: Guarda este archivo como referencia rápida para futuras ejecuciones*