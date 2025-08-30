@echo off
REM =====================================================
REM Symbiosis - Ultra Full Silencioso
REM =====================================================

REM ----- Carpeta del proyecto -----
set PROJECT_PATH=C:\Users\nitropc\Desktop\PROYECTO SIMBIOSIS
cd /d "%PROJECT_PATH%"

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

REM ----- Instalar dependencias -----
python -m pip install --upgrade pip >nul 2>&1
IF EXIST requirements.txt (
    python -m pip install -r requirements.txt >nul 2>&1
)

REM ----- Sincronizar Git automáticamente -----
git --version >nul 2>&1
IF ERRORLEVEL 0 (
    git config --global user.name "Mario Perez Fuertes"
    git config --global user.email "marioperezfuertes@gmail.com"
    IF EXIST ".git" (
        git remote remove origin >nul 2>&1
        git remote add origin https://github.com/marioperezfuertes-svg/symbiosis-enhanced.git
        git pull origin main --allow-unrelated-histories --no-edit >nul 2>&1
        git add . >nul 2>&1
        git commit -m "Actualización automática" >nul 2>&1
        git push origin main >nul 2>&1
    )
)

REM ----- Ejecutar proyecto -----
start "" python scripts/dev.py

exit
