# 🚀 Guía de Instalación y Ejecución - Finanzas App

## 📋 Prerrequisitos

### 1. Instalar Flutter SDK

#### **Windows:**
1. Descarga Flutter desde: https://docs.flutter.dev/get-started/install/windows
2. Extrae el archivo ZIP a `C:\src\flutter`
3. Agrega `C:\src\flutter\bin` al PATH del sistema

#### **macOS:**
```bash
# Usando Homebrew (recomendado)
brew install flutter

# O descarga manual desde: https://docs.flutter.dev/get-started/install/macos
```

#### **Linux:**
```bash
# Descargar Flutter
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
tar xf flutter_linux_3.16.0-stable.tar.xz

# Agregar al PATH
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 2. Verificar Instalación
```bash
flutter doctor
```

Este comando verificará que todo esté configurado correctamente.

### 3. Instalar Android Studio (para emulador Android)
1. Descarga desde: https://developer.android.com/studio
2. Instala Android SDK y herramientas
3. Configura un emulador Android

### 4. Configurar Editor (opcional pero recomendado)
- **VS Code**: Instala la extensión "Flutter"
- **Android Studio**: Instala plugins Flutter y Dart

## 🔧 Configuración del Proyecto

### 1. Crear Directorios Faltantes
```bash
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/animations
mkdir -p assets/fonts
```

### 2. Verificar Dependencias
Asegúrate de que el archivo `pubspec.yaml` esté completo y actualizado.

### 3. Instalar Dependencias
```bash
flutter pub get
```

### 4. Verificar Dispositivos Disponibles
```bash
flutter devices
```

## ▶️ Ejecutar la Aplicación

### Opción 1: Desde la Terminal
```bash
# Ejecutar en modo debug
flutter run

# Ejecutar en dispositivo específico
flutter run -d <device-id>

# Ejecutar en modo release (más rápido)
flutter run --release
```

### Opción 2: Desde VS Code
1. Abre el proyecto en VS Code
2. Presiona `F5` o usa `Run > Start Debugging`
3. Selecciona el dispositivo target

### Opción 3: Desde Android Studio
1. Abre el proyecto
2. Selecciona un dispositivo/emulador
3. Presiona el botón "Run" (▶️)

## 📱 Opciones de Dispositivos

### 1. Emulador Android
```bash
# Listar emuladores disponibles
flutter emulators

# Ejecutar emulador específico
flutter emulators --launch <emulator-id>
```

### 2. Dispositivo Android Físico
1. Habilita "Opciones de desarrollador" en tu dispositivo
2. Activa "Depuración USB"
3. Conecta via USB y acepta el prompt

### 3. Simulador iOS (solo macOS)
```bash
# Abrir simulador
open -a Simulator

# Ejecutar en simulador
flutter run -d ios
```

### 4. Web (Chrome)
```bash
# Habilitar soporte web
flutter config --enable-web

# Ejecutar en navegador
flutter run -d chrome
```

## 🐛 Solución de Problemas Comunes

### Error: "Flutter SDK not found"
```bash
# Verificar instalación
which flutter
flutter doctor

# Re-agregar al PATH si es necesario
export PATH="$PATH:/path/to/flutter/bin"
```

### Error: "Android SDK not found"
1. Abre Android Studio
2. Ve a Tools > SDK Manager
3. Instala Android SDK Platform-Tools

### Error: "No connected devices"
```bash
# Verificar dispositivos
adb devices

# Reiniciar servidor ADB si es necesario
adb kill-server
adb start-server
```

### Error: "CocoaPods not installed" (macOS)
```bash
sudo gem install cocoapods
cd ios
pod install
```

### Error: Dependencias no encontradas
```bash
# Limpiar cache
flutter clean

# Re-instalar dependencias
flutter pub get

# Regenerar archivos si usas build_runner
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 🔄 Hot Reload y Hot Restart

Una vez que la app esté ejecutándose:

- **Hot Reload**: Presiona `r` en la terminal o `Ctrl+S` en VS Code
- **Hot Restart**: Presiona `R` en la terminal
- **Quit**: Presiona `q` en la terminal

## 📦 Construcción para Producción

### Android APK
```bash
# Construir APK
flutter build apk

# APK optimizado por arquitectura
flutter build apk --split-per-abi
```

### Android App Bundle (recomendado para Play Store)
```bash
flutter build appbundle
```

### iOS (solo macOS)
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## 🎯 Comandos Útiles Durante Desarrollo

```bash
# Ver logs en tiempo real
flutter logs

# Analizar el rendimiento
flutter run --profile

# Generar archivos de código (si usas build_runner)
flutter packages pub run build_runner build

# Verificar problemas potenciales
flutter analyze

# Ejecutar tests
flutter test

# Actualizar dependencias
flutter pub upgrade
```

## 📊 Monitoreo y Depuración

### Flutter Inspector
- En VS Code: `Ctrl+Shift+P` > "Flutter: Open Inspector"
- En Android Studio: Pestaña "Flutter Inspector"

### Performance Overlay
```bash
# Ejecutar con overlay de rendimiento
flutter run --enable-performance-overlay
```

### Debug Console
Los `print()` statements aparecerán en:
- Terminal donde ejecutaste `flutter run`
- Debug Console en VS Code
- Run tab en Android Studio

## 🔐 Configuración de Seguridad (Opcional)

Para funcionalidades biométricas en dispositivos reales:

### Android
Agrega al `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

### iOS
Agrega al `ios/Runner/Info.plist`:
```xml
<key>NSFaceIDUsageDescription</key>
<string>Esta app usa Face ID para autenticación segura</string>
```

## ✅ Verificación Final

Si todo está correcto, deberías ver:
1. La pantalla de splash/onboarding
2. Dashboard con tarjetas de resumen
3. Navegación inferior funcionando
4. Transiciones suaves entre pantallas

## 🆘 ¿Problemas? Contacto de Soporte

Si encuentras algún error:
1. Ejecuta `flutter doctor -v` y comparte el output
2. Revisa los logs con `flutter logs`
3. Verifica que todas las dependencias estén instaladas
4. Asegúrate de estar usando Flutter 3.10+ y Dart 3.0+

---

*¡Disfruta explorando tu nueva app de finanzas personales! 💰📱*