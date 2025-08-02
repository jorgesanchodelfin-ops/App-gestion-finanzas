@echo off
cls

echo 🚀 Finanzas App - Script de Ejecución
echo =====================================
echo.

:: Verificar si Flutter está instalado
echo [INFO] Verificando Flutter...
flutter --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Flutter no está instalado. Por favor instálalo desde:
    echo https://docs.flutter.dev/get-started/install/windows
    pause
    exit /b 1
) else (
    echo [✓] Flutter encontrado
)

:: Ejecutar flutter doctor
echo [INFO] Verificando configuración de Flutter...
flutter doctor

:: Verificar dispositivos disponibles
echo [INFO] Verificando dispositivos disponibles...
flutter devices

:: Verificar e instalar dependencias
echo [INFO] Verificando dependencias...
if not exist ".dart_tool" (
    echo [INFO] Instalando dependencias...
    flutter pub get
    if errorlevel 1 (
        echo [ERROR] Error al instalar dependencias
        pause
        exit /b 1
    ) else (
        echo [✓] Dependencias instaladas correctamente
    )
) else (
    echo [✓] Dependencias ya instaladas
)

:: Crear directorios de assets si no existen
echo [INFO] Verificando estructura de assets...
if not exist "assets\images" mkdir "assets\images"
if not exist "assets\icons" mkdir "assets\icons"
if not exist "assets\animations" mkdir "assets\animations"
if not exist "assets\fonts" mkdir "assets\fonts"
echo [✓] Estructura de assets verificada

:: Menú de opciones
echo.
echo [INFO] ¿Cómo deseas ejecutar la aplicación?
echo 1. Modo debug (recomendado para desarrollo)
echo 2. Modo release (más rápido)
echo 3. En navegador web
echo 4. Seleccionar dispositivo específico
echo 5. Solo verificar (no ejecutar)
echo.

set /p choice="Selecciona una opción (1-5): "

if "%choice%"=="1" (
    echo [INFO] Ejecutando en modo debug...
    flutter run
) else if "%choice%"=="2" (
    echo [INFO] Ejecutando en modo release...
    flutter run --release
) else if "%choice%"=="3" (
    echo [INFO] Habilitando soporte web...
    flutter config --enable-web
    echo [INFO] Ejecutando en navegador...
    flutter run -d chrome
) else if "%choice%"=="4" (
    echo [INFO] Dispositivos disponibles:
    flutter devices
    echo.
    set /p device_id="Ingresa el ID del dispositivo: "
    echo [INFO] Ejecutando en dispositivo: !device_id!
    flutter run -d "!device_id!"
) else if "%choice%"=="5" (
    echo [✓] Verificación completada. Todo listo para ejecutar.
    echo [INFO] Para ejecutar manualmente usa: flutter run
) else (
    echo [WARNING] Opción no válida. Ejecutando en modo debug por defecto...
    flutter run
)

echo.
echo [✓] ¡Disfruta tu aplicación de finanzas! 💰📱
pause