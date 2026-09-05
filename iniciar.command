#!/bin/bash
# ==========================================================
# SCRIPT DE INICIO - SISTEMA DE CONTINGENCIAS SBSG (UNIX/MAC)
# ==========================================================

cd "$(dirname "$0")"

echo "=========================================================="
echo "    SISTEMA DE CONTINGENCIAS Y REEMPLAZOS DOCENTES SBSG   "
echo "=========================================================="

# 1. Detectar Java
JAVA_CMD=""
if [ -n "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/java" ]; then
    JAVA_CMD="$JAVA_HOME/bin/java"
elif [ -x "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/bin/java" ]; then
    JAVA_CMD="/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/bin/java"
elif ls /Library/Java/JavaVirtualMachines/*/Contents/Home/bin/java 1>/dev/null 2>&1; then
    JAVA_CMD=$(ls /Library/Java/JavaVirtualMachines/*/Contents/Home/bin/java | tail -n 1)
elif [ -x "/usr/libexec/java_home" ]; then
    DETECTED_HOME=$(/usr/libexec/java_home -v 21 2>/dev/null || /usr/libexec/java_home 2>/dev/null)
    if [ -n "$DETECTED_HOME" ] && [ -x "$DETECTED_HOME/bin/java" ]; then
        JAVA_CMD="$DETECTED_HOME/bin/java"
    fi
elif [ -x "$HOME/.sdkman/candidates/java/current/bin/java" ]; then
    JAVA_CMD="$HOME/.sdkman/candidates/java/current/bin/java"
elif command -v java >/dev/null 2>&1; then
    JAVA_CMD="java"
fi

if [ -z "$JAVA_CMD" ]; then
    echo "[ERROR] No se encontró Java instalado en el sistema."
    echo "Por favor instale Java 21 (JDK o JRE) para ejecutar el sistema."
    exit 1
fi

echo "Entorno Java: $("$JAVA_CMD" -version 2>&1 | head -n 1)"
echo "Iniciando servidor en puerto 8080..."
echo "Acceso Web: http://localhost:8080"
echo "Para detener el servidor presiona CTRL + C"
echo "=========================================================="

# Abrir el navegador automáticamente tras unos segundos
(sleep 3 && open "http://localhost:8080" 2>/dev/null) &

JAR_FILE="backend/target/contingencias-sbsg.jar"
if [ ! -f "$JAR_FILE" ]; then
    JAR_FILE="backend/target/contingencias-backend-1.0.0.jar"
fi

if [ -f "$JAR_FILE" ]; then
    "$JAVA_CMD" -jar "$JAR_FILE"
else
    echo "[ERROR] No se encontró el archivo JAR ejecutable en backend/target."
    exit 1
fi
