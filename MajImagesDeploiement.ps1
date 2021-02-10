# Pour les explications relatives à ce "try catch" voir ligne 80
try
{
# Variable contenant le chemin vers le fichier de configuration

$confPath = "C:\scripts\Conf.psd1"

$configFile = Import-PowerShellDataFile -Path $confPath -ErrorAction Stop

# Récupère le fichier module contenant toute les fonctions gérant les erreurs et les appelle ensuite. Le chemin vers ce fichier se trouve dans le fichier de configuration

Import-module "$($configFile.Arborescence.FONCTIONPATH)"

# Début de l'appel des fonctions de gestion d'erreurs

ArborescenceLETTRELECTEUR

ArborescenceMONTAGE

ArborescenceUPDATES

ArborescenceSOURCES

ArborescenceISOINSTALLWIM

ArborescenceINSTALLWIM

ArborescenceISOPATH

ArborescenceFONCTIONPATH

WsusIP

WsusPARTAGEPATH

WsusEXTENSIONFICHIER

WDSGROUPEIMAGE

# Fin de l'appel des fonctions de gestion d'erreurs

$LetterISO = (Mount-DiskImage -ImagePath "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.ISOPATH)" -StorageType ISO -PassThru -ErrorAction Stop | Get-Volume).DriveLetter + ':'

# Récupére les mises à jour du serveur WSUS

Set-location \\$($configFile.Wsus.IP)$($configFile.Wsus.PARTAGEPATH)

Get-ChildItem -Path $configFile.Wsus.EXTENSIONFICHIER -Recurse | Copy-Item -Destination "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.UPDATES)"

Set-Location $configFile.Arborescence.LETTRELECTEUR

#Récupere le fichier install.wim stocké dans l'iso

Copy-Item ($LetterISO + $($configFile.Arborescence.ISOINSTALLWIM)) -Destination "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.SOURCES)"

Set-ItemProperty -Path "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)" -Name isreadonly -Value $false

# Monte un par un les index du fichier install.wim, lui injecte les mises à jour, puis le démonte

$array = (Get-WindowsImage -imagepath "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)").count

for ( $index = 1; $index -le $array; $index++)
{
    Dism /mount-wim /wimfile:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)" /index:"$index" /Mountdir:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.MONTAGE)"

    Dism /Image:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.MONTAGE)" /add-package /packagepath:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.UPDATES)"

    Dism /unmount-wim /Mountdir:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.MONTAGE)" /commit
}

# Ajouter le fichier install.wim et ses index désormais à jour dans le banc de déploiement WDS

wdsutil /Verbose /Progress /add-Image /imageFile:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)" /imagetype:Install /imageGroup:"$($configFile.WDSGROUPIMAGE)" 

# Démonte l'ISO

Dismount-DiskImage -ImagePath "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.ISOPATH)"
}

# Ce "try catch" parent englobe tout le script afin de rediriger les erreurs, dans un fichier, des "try catch" enfants appellés par les fonctions, mais aussi les possibles erreurs systèmes non gérées par les fonctions
catch
{

        get-date -Format "[yyyy-MM-dd HH:mm:ss]"  | Out-File "D:\test.txt" -Append
        throw $PSItem.Exception.Message | Out-File "D:\test.txt" -Append
}