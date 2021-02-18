# Vide le "cache" PowerShell et permet de prendre en compte les modifications dans le fichier module

Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

# Fonction qui va créer, si il n'existe pas, un fichier de log où les messages d'erreurs seront redirigés

ArborescenceWsusLOGPATH

# Pour les explications relatives à ce "try catch" voir ligne 99-100

try
{

# Variable permettant d'appeler les constantes du fichier de configuration

$confPath = "C:\Users\Administrateur\Documents\GitHub\MAJImagesWDS\confWsus.psd1"

$configFile = Import-PowerShellDataFile -path $confPath -ErrorAction Stop

# Vérifie si le service WSUS est bien installé sur le serveur

TESTSERVICESWSUS

# Test si le fichier module existe bien

ArborescenceWsusFONCTIONPATH

Import-Module "$($configFile.ArborescenceWsus.FONCTIONPATH)"

# Début de l'appel des fonctions de gestion d'erreurs

OSVERSION

OSARCHITECTURE

ArborescenceWsusLETTRELECTEUR

ArborescenceWsusMAJFOLDER

ArborescenceWsusMAJPATH

# Fin de l'appel des fonctions de gestion d'erreurs

$date = get-date -Format "[yyyy-MM-dd HH:mm:ss] "

# Début de la synchronisation WSUS

(Get-WsusServer).GetSubscription().StartSynchronization()

# Afin que le script rentre dans la boucle While, on le stop 20 secondes le temps que la synchronisation commence

Start-Sleep -Seconds 20

# Cette boucle permet de s'assurer que le script ne continuera pas sa progression tant que la synchronisation n'est pas terminée

while((Get-WsusServer).GetSubscription().GetSynchronizationProgress().ProcessedItems -and (Get-WsusServer).GetSubscription().GetSynchronizationProgress().TotalItems -ne '0')
{
    (Get-WsusServer).GetSubscription().GetSynchronizationProgress()

    Start-Sleep -Seconds 60
}

# Les mises à jour sont approuvées afin que WSUS les télécharge

Get-WsusUpdate -Classification All -Approval Declined | ? {$_.Update.ProductTitles -like "*" + $($configFile.OSVERSION) + "*"} | ? {$_.Update.Title -like "*" + $($configFile.OSARCHITECTURE) + "*"} | ? {$_.Update.IsSuperseded -eq $false} | Approve-WsusUpdate -TargetGroupName "Tous les ordinateurs" -Action Install

Get-WsusUpdate -Classification All -Approval AnyExceptDeclined | ? {$_.Update.ProductTitles -like  "*" + $($configFile.OSVERSION) + "*"} | ? {$_.Update.Title -like "*" + $($configFile.OSARCHITECTURE) + "*"} | ? {$_.Update.IsSuperseded -eq $false} | Approve-WsusUpdate -TargetGroupName "Tous les ordinateurs" -Action Install

# Le téléchargement des mises à jour n'est pas toujours immédiat, le script se stop donc 20 secondes le temps que le téléchargement commence
Start-Sleep -Seconds 20

# Cette boucle permet de s'assurer que le script ne continuera pas sa progression tant que le téléchargement des mises à jour n'est pas terminé

while((Get-WsusServer).GetContentDownloadProgress().DownloadedBytes -lt (Get-WsusServer).GetContentDownloadProgress().TotalBytesToDownload)
{    
    (Get-WsusServer).GetContentDownloadProgress()

    Start-Sleep -Seconds 60
}

# Création du dossier auquel le serveur WDS accédera afin de récupérer les fichiers de mises à jour

New-Item -Path "$($configFile.ArborescenceWsus.LETTRELECTEUR)$($configFile.ArborescenceWsus.MAJFOLDER)$($configFile.ArborescenceWsus.MAJFOLDERSHARE)" -ItemType Directory

# Transfert des fichiers de mises à jour dans le dossier qui vient d'être crée

Get-ChildItem -Path "$($configFile.ArborescenceWsus.LETTRELECTEUR)$($configFile.ArborescenceWsus.MAJFOLDER)$($configFile.ArborescenceWsus.MAJEXTENSION)" -Recurse | Move-Item -Destination "$($configFile.ArborescenceWsus.LETTRELECTEUR)$($configFile.ArborescenceWsus.MAJFOLDER)$($configFile.ArborescenceWsus.MAJFOLDERSHARE)"

# Les mises à jour approuvées sont passées en refusées afin que les versions des mises à jour ne soient pas mélangées. Cela évite de télécharger des mises à jour de Windows 10 et Windows server en même temps

Get-WsusUpdate -Classification All -Approval AnyExceptDeclined | ? {$_.Update.ProductTitles -like "*" + $($configFile.OSVERSION) + "*"} | ? {$_.Update.Title -like "*" + $($configFile.OSARCHITECTURE) + "*"} | Deny-WsusUpdate

# Appel d'une fonction qui "nettoie" WSUS en supprimant les mises à jour obsolètes, remplacées ou inutiles

PURGEWSUS

}

# Ce "try catch" parent parcourt tout le script afin de faire remonter les erreurs des "try catch" enfants appellés par les fonctions, mais aussi les possibles erreurs systèmes non gérées par les fonctions
# Le message d'erreur est ensuite inscrit dans le fichier de log
catch
{
    Write-Host -BackgroundColor Black -ForegroundColor Red "Le fichier de log est disponible ici : $($configFile.ArborescenceWsus.LOGPATH)"
    $date | Out-File "$($configFile.ArborescenceWsus.LOGPATH)" -Append -NoNewline
    throw $PSItem.Exception.Message | Out-File "$($configFile.ArborescenceWsus.LOGPATH)" -Append
}