# Vide le "cache" PowerShell et permet de prendre en compte les modifications dans le fichier module

Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

$date = get-date -Format "[yyyy-MM-dd HH:mm:ss] "

# Variable permettant d'appeler les constantes du fichier de configuration

$confPath = "C:\scripts\ConfWds.psd1"

$configFile = Import-PowerShellDataFile -Path $confPath -ErrorAction Stop

# Fonction qui va créer, si il n'existe pas, un fichier de log où les messages d'erreurs seront redirigés

ArborescenceWdsLOGPATH

# Pour les explications relatives à ce "try catch" voir lignes 96-97
try
{

# Vérifie si le service WDS est bien installé sur ce serveur

TESTSERVICESWDS

# Récupère le fichier module contenant toute les fonctions gérant les erreurs et les appelle ensuite

ArborescenceWdsFONCTIONPATH

Import-module "$($configFile.ArborescenceWds.FONCTIONPATH)"

# Début de l'appel des fonctions de gestion d'erreurs

ArborescenceWdsLETTRELECTEUR

ArborescenceWdsMONTAGE

ArborescenceWdsISOINSTALLWIM

ArborescenceWdsINSTALLWIM

ArborescenceWdsISOPATH

WsusIP

WsusMAJFOLDER

WsusMAJFOLDERSHARE

WDSGROUPEIMAGE

WDSGROUPEIMAGEPATH

# Fin de l'appel des fonctions de gestion d'erreurs

# Montage de l'ISO et récupération de sa lettre de lecteur

$LetterISO = (Mount-DiskImage -ImagePath "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.ISOPATH)" -StorageType ISO -PassThru -ErrorAction Stop | Get-Volume).DriveLetter + ':'

# Récupere le fichier install.wim stocké dans l'iso

Copy-Item ($LetterISO + $($configFile.ArborescenceWds.ISOINSTALLWIM)) -Destination "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.INSTALWIM)"

Set-ItemProperty -Path "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.INSTALLWIM)" -Name isreadonly -Value $false

# Monte un par un les index du fichier install.wim, lui injecte les mises à jour, puis le démonte

$array = (Get-WindowsImage -imagepath "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.INSTALLWIM)").count

for ( $index = 1; $index -le $array; $index++)
{
    Mount-WindowsImage -ImagePath "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.INSTALLWIM)" -Path "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.MONTAGE)" -Index $index -CheckIntegrity  -ErrorAction SilentlyContinue

    Add-WindowsPackage -PackagePath "\\$($configFile.Wsus.IP)$($configFile.Wsus.MAJFOLDER)$($configFile.Wsus.MAJPATH)" -Path "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.MONTAGE)"  -ErrorAction SilentlyContinue
    
    Dismount-WindowsImage -Path "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.MONTAGE)" -Save  -ErrorAction SilentlyContinue
}

# Ajouter le fichier install.wim et ses index, désormais à jour, dans le banc de déploiement WDS

wdsutil /Verbose /Progress /add-Image /imageFile:"$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.INSTALLWIM)" /imagetype:Install /imageGroup:"$($configFile.WDSGROUPIMAGE)" 

# Démonte l'ISO

Dismount-DiskImage -ImagePath "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.ISOPATH)"

# Efface le fichier install.wim, le chemin de montage ainsi que le répertoire contenant les mises à jour sur le serveur WSUS

Remove-item -Path "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.INSTALLWIM)" -Recurse -Force

Remove-item -Path "$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.MONTAGE)" -Recurse -Force

Remove-item -Path "\\$($configFile.Wsus.IP)$($configFile.Wsus.MAJFOLDER)\" -Recurse -Force

}

# Ce "try catch" parent parcourt tout le script afin de faire remonter les erreurs des "try catch" enfants appellés par les fonctions, mais aussi les possibles erreurs systèmes non gérées par les fonctions
# Le message d'erreur est ensuite inscrit dans le fichier de log
catch
{
        Write-Host -BackgroundColor Black -ForegroundColor Red "Le fichier de log est disponible ici : $($configFile.ArborescenceWds.LOGPATH)"
        $date | Out-File "$($configFile.ArborescenceWds.LOGPATH)" -Append -NoNewline
        throw $PSItem.Exception.Message | Out-File "$($configFile.ArborescenceWds.LOGPATH)" -Append
        
}