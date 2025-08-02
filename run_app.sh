#!/bin/bash

# 🚀 Script de Ejecución Rápida - Finanzas App
# Este script verifica que todo esté configurado y ejecuta la aplicación

echo "🚀 Finanzas App - Script de Ejecución"
echo "=====================================\n"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar mensajes
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Verificar si Flutter está instalado
print_status "Verificando Flutter..."
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -n1)
    print_success "Flutter encontrado: $FLUTTER_VERSION"
else
    print_error "Flutter no está instalado. Por favor instálalo desde:"
    echo "https://docs.flutter.dev/get-started/install"
    exit 1
fi

# Ejecutar flutter doctor
print_status "Verificando configuración de Flutter..."
flutter doctor

# Verificar dispositivos disponibles
print_status "Verificando dispositivos disponibles..."
DEVICES=$(flutter devices --suppress-analytics)
echo "$DEVICES"

if [[ $DEVICES == *"No devices"* ]]; then
    print_warning "No se encontraron dispositivos conectados."
    print_status "Opciones:"
    echo "1. Conecta un dispositivo Android via USB"
    echo "2. Inicia un emulador Android"
    echo "3. Usa el simulador iOS (solo macOS)"
    echo "4. Ejecuta en navegador web"
    echo ""
    read -p "¿Deseas continuar de todos modos? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Verificar si las dependencias están instaladas
print_status "Verificando dependencias..."
if [ ! -d ".dart_tool" ]; then
    print_status "Instalando dependencias..."
    flutter pub get
    if [ $? -eq 0 ]; then
        print_success "Dependencias instaladas correctamente"
    else
        print_error "Error al instalar dependencias"
        exit 1
    fi
else
    print_success "Dependencias ya instaladas"
fi

# Verificar directorios de assets
print_status "Verificando estructura de assets..."
for dir in "assets/images" "assets/icons" "assets/animations" "assets/fonts"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        print_status "Creado directorio: $dir"
    fi
done
print_success "Estructura de assets verificada"

# Ofrecer opciones de ejecución
echo ""
print_status "¿Cómo deseas ejecutar la aplicación?"
echo "1. Modo debug (recomendado para desarrollo)"
echo "2. Modo release (más rápido)"
echo "3. En navegador web"
echo "4. Seleccionar dispositivo específico"
echo "5. Solo verificar (no ejecutar)"

read -p "Selecciona una opción (1-5): " choice

case $choice in
    1)
        print_status "Ejecutando en modo debug..."
        flutter run
        ;;
    2)
        print_status "Ejecutando en modo release..."
        flutter run --release
        ;;
    3)
        print_status "Habilitando soporte web..."
        flutter config --enable-web
        print_status "Ejecutando en navegador..."
        flutter run -d chrome
        ;;
    4)
        print_status "Dispositivos disponibles:"
        flutter devices
        echo ""
        read -p "Ingresa el ID del dispositivo: " device_id
        print_status "Ejecutando en dispositivo: $device_id"
        flutter run -d "$device_id"
        ;;
    5)
        print_success "Verificación completada. Todo listo para ejecutar."
        print_status "Para ejecutar manualmente usa: flutter run"
        ;;
    *)
        print_warning "Opción no válida. Ejecutando en modo debug por defecto..."
        flutter run
        ;;
esac

echo ""
print_success "¡Disfruta tu aplicación de finanzas! 💰📱"