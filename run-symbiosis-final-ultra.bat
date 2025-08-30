@echo off
REM =====================================================
REM Symbiosis - Ultra rápida y conjunta
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

REM ----- Intentar sincronizar Git (opcional) -----
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
) ELSE (
    echo Git no instalado, skip sincronizacion.
)

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
echo Proyecto ejecutado correctamente.
echo Presiona cualquier tecla para cerrar...
pause
