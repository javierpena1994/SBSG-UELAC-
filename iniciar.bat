@echo off
REM ==========================================================
REM SCRIPT DE INICIO - SISTEMA DE CONTINGENCIAS SBSG (WINDOWS)
REM ==========================================================

cd /d "%~dp0"

echo ==========================================================
echo     SISTEMA DE CONTINGENCIAS Y REEMPLAZOS DOCENTES SBSG   
echo ==========================================================

REM Verificar Java
where java >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    if defined JAVA_HOME (
        set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
    ) else (
        echo [ERROR] No se encontro Java instalado en el PATH.
        echo Por favor instale Java 21 o configure la variable JAVA_HOME.
        pause
        exit /b 1
    )
) else (
    set "JAVA_CMD=java"
)

echo Iniciando servidor en puerto 8080...
echo Acceso Web: http://localhost:8080
echo Para detener el sistema cierre esta ventana o presione CTRL + C
echo ==========================================================

start "" http://localhost:8080

if exist "backend\target\contingencias-sbsg.jar" (
    "%JAVA_CMD%" -jar "backend\target\contingencias-sbsg.jar"
) else if exist "backend\target\contingencias-backend-1.0.0.jar" (
    "%JAVA_CMD%" -jar "backend\target\contingencias-backend-1.0.0.jar"
) else (
    echo [ERROR] No se encontro el archivo JAR ejecutable en backend\target.
    pause
    exit /b 1
)
