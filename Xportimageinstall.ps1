#Déclaration des variables

$configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop

$MountISO = Mount-DiskImage -ImagePath "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.CHEMINISO)" -StorageType ISO -PassThru

$LetterISO = ($MountISO | Get-Volume).DriveLetter + ':'

# Récupérer les mises à jour du serveur WSUS

Set-location \\$($configFile.Wsus.IP)$($configFile.Wsus.CHEMINPARTAGE)

WSUSIP

Get-ChildItem -Path $configFile.Wsus.EXTENSIONFICHIER -Recurse | Copy-Item -Destination "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.UPDATES)"

Set-Location $configFile.Arborescence.LETTRELECTEUR

#Récuperer le install.wim qui doit être modifié

Copy-Item ($LetterISO + $($configFile.Arborescence.ISOINSTALLWIM)) -Destination "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.SOURCES)"

Set-ItemProperty -Path "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)" -Name isreadonly -Value $false

# Monter le install.wim et lui injecter les mises à jour, puis le démonter

$array = (Get-WindowsImage -imagepath "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)").count

for ( $index = 1; $index -le $array; $index++)
{
    Dism /mount-wim /wimfile:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)" /index:"$index" /Mountdir:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.MONTAGE)"

    Dism /Image:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.MONTAGE)" /add-package /packagepath:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.UPDATES)"

    Dism /unmount-wim /Mountdir:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.MONTAGE)" /commit
}

#Créer un nouveau groupe d'images et y ajouter le install.wim avec les mises à jour dedans

wdsutil /Verbose /add-ImageGroup /imageGroup:"$($configFile.WDSGROUPIMAGE)"

wdsutil /Verbose /Progress /add-Image /imageFile:"$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.INSTALLWIM)" /imagetype:Install /imageGroup:"$($configFile.WDSGROUPIMAGE)" 

# Démonter l'ISO

Dismount-DiskImage -ImagePath "$($configFile.Arborescence.LETTRELECTEUR)$($configFile.Arborescence.CHEMINISO)"