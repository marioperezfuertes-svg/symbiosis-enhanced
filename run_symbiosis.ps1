# Archivo: run_symbiosis.ps1
# Ejecuta todo automáticamente

Start-Process "code" "C:\Users\nitropc\Desktop\PROYECTO SIMBIOSIS"

cd "C:\Users\nitropc\Desktop\PROYECTO SIMBIOSIS"

git init
git add .
git commit -m "Primer commit"
git branch -M main
git remote add origin https://github.com/marioperezfuertes-svg/symbiosis-enhanced.git
git push -u origin main

python -m pip install --upgrade pip
python -m pip install -r requirements.txt

python scripts/dev.py
