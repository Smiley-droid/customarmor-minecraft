@echo off
REM Build script pour le datapack "CustomArmor" (Windows)
REM Double-clique sur ce fichier pour generer customarmor.zip

echo Build du datapack CustomArmor...

if exist customarmor.zip del customarmor.zip

powershell -NoProfile -Command "Compress-Archive -Path 'pack.mcmeta','data' -DestinationPath 'customarmor.zip' -Force"

if exist customarmor.zip (
    echo.
    echo OK : customarmor.zip genere dans ce dossier.
    echo Copie ce fichier dans world\datapacks\ sur ton serveur, puis fais /reload en jeu.
) else (
    echo.
    echo ERREUR : le zip n'a pas ete cree. Verifie que pack.mcmeta et le dossier data existent bien ici.
)

echo.
pause
