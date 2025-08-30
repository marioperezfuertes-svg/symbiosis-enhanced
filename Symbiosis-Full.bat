@echo off
REM =====================================================
REM Symbiosis - Full automático (Git + dependencias + ejecución)
REM =====================================================

REM ----- Carpeta del proyecto -----
set PROJECT_PATH=C:\Users\nitropc\Desktop\PROYECTO SIMBIOSIS
cd /d "%PROJECT_PATH%"

REM ----- Comprobar Python -----
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo ERROR: Python no esta instalado o no esta agregado al PATH.
    pause
    exit /b
)

REM ----- Crear archivos faltantes automáticamente -----
IF NOT EXIST requirements.txt (
    echo > requirements.txt
)
IF NOT EXIST scripts (
    mkdir scripts
)
IF NOT EXIST scripts\dev.py (
    echo print("Hola, Symbiosis se esta ejecutando correctamente!") > scripts\dev.py
)

REM ----- Configurar Git automáticamente -----
git --version >nul 2>&1
IF ERRORLEVEL 0 (
    git config --global user.name "Mario Perez Fuertes"
    git config --global user.email "marioperezfuertes@gmail.com"
    IF EXIST ".git" (
        git remote remove origin >nul 2>&1
        git remote add origin https://github.com/marioperezfuertes-svg/symbiosis-enhanced.git
        git pull origin main --allow-unrelated-histories --no-edit
        git add .
        git commit -m "Actualización automática" >nul 2>&1
        git push origin main
    ) ELSE (
        echo Git no inicializado, skip sincronizacion.
    )
)

REM ----- Instalar dependencias -----
python -m pip install --upgrade pip >nul
IF EXIST requirements.txt (
    python -m pip install -r requirements.txt >nul
)

REM ----- Ejecutar proyecto -----
python scripts/dev.py

REM ----- Final -----
exit
