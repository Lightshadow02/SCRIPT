@echo off
REM Configure la page de code de la console en UTF-8 pour les caractères spéciaux
chcp 65001 > nul

REM Crée une unité d'organisation (OU) nommée "Qualite" dans le domaine "GSB.COM"
dsadd ou OU=Qualite,DC=GSB,DC=COM

REM Crée des groupes à partir des noms dans le fichier "groupe.txt"
FOR /F %%i in (groupe.txt) do (
    dsadd group "CN=%%i,OU=Qualite,DC=GSB,DC=COM"
)

REM Lit le fichier "utiliqualite.txt" et effectue des actions pour chaque ligne
FOR /F "tokens=1,2,3 skip=1" %%i in (utiliqualite.txt) DO (
    REM Crée un nouvel utilisateur avec divers paramètres
    dsadd user -loscr loginQualite.bat "CN=%%i,OU=Qualite,DC=GS,DC=COM" -memberof "CN=%%k,OU=Qualite,DC=GSB,DC=COM" -disabled no -pwd Test1234 -hmdir M: -profile \\SRVCLINIQUE-A\Perso\%%i
    REM Configure les autorisations sur le répertoire "C:\Travail\%%k"
    icacls C:\Travail\%%k /grant %%k:M
    icacls C:\Travail\%%k\ /grant administrateur:F
    icacls C:\Travail\%%k\ /inheritance:R
    REM Partage le répertoire "%%k" via le réseau
    net share %%k="C:\Travail\%%k"
)


REM Crée des répertoires en fonction des informations dans "utiliqualite.txt"
FOR /F "tokens=1,2,3 skip=1" %%i in (utiliqualite.txt) do (
    mkdir C:\Perso\%%k\%%i
)

REM Configure les autorisations sur les répertoires créés
FOR /F "tokens=1,2,3 skip=1" %%i IN (utiliqualite.txt) DO (
    icacls C:\Perso\%%k /grant %%k:M
    icacls "C:\Perso\%%k\%%i" /grant "%%i:M"
    icacls "C:\Perso\%%k\%%i" /inheritance:R
    REM Met en pause le script
    
)

