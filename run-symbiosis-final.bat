@echo off
REM =====================================================
REM Script final Symbiosis - Auto sincronización Git
REM =====================================================

REM ----- Carpeta del proyecto -----
set PROJECT_PATH=C:\Users\nitropc\Desktop\PROYECTO SIMBIOSIS
cd /d "%PROJECT_PATH%"

REM ----- Comprobar Git -----
git --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo ERROR: Git no esta instalado. Instala Git y vuelve a ejecutar.
    pause
    exit /b
)

REM ----- Comprobar Python -----
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo ERROR: Python no esta instalado o no esta agregado al PATH.
    pause
    exit /b
)

REM ----- Configurar usuario Git -----
git config --global user.name "Mario Perez Fuertes"
git config --global user.email "marioperezfuertes@gmail.com"

REM ----- Inicializar Git si no existe -----
IF NOT EXIST ".git" (
    echo Inicializando Git...
    git init
    git add .
    git commit -m "Primer commit"
    git branch -M main
    git remote add origin https://github.com/marioperezfuertes-svg/symbiosis-enhanced.git
)

REM ----- Sincronizar con GitHub (pull + merge automático) -----
echo Sincronizando con GitHub...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/marioperezfuertes-svg/symbiosis-enhanced.git
git pull origin main --allow-unrelated-histories --no-edit

REM ----- Agregar y hacer commit automático de cambios locales -----
git add .
git commit -m "Actualización automática" >nul 2>&1
git push origin main

REM ----- Instalar dependencias -----
IF EXIST requirements.txt (
    echo Instalando dependencias...
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
) ELSE (
    echo No se encontro requirements.txt, saltando instalacion de dependencias.
)

REM ----- Ejecutar proyecto -----
IF EXIST scripts\dev.py (
    echo Ejecutando proyecto...
    python scripts/dev.py
) ELSE (
    echo No se encontro scripts\dev.py, saltando ejecucion.
)

REM ----- Final -----
echo.
echo =====================================================
echo Proyecto ejecutado correctamente con sincronizacion Git.
echo Presiona cualquier tecla para cerrar...
pause
