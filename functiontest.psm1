$configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
function WSUSExtension 
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = ".\*.cab"
    try {
        if(!($($configFile.Wsus.EXTENSIONFICHIER) -match $pattern))
            {
            throw "L'extension du fichier n'est pas la bonne"
            }
        }
     catch
        { 
            throw $PSItem.Exception.Message  
        }
}

function WSUSIP {
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    try { 

        if (!($($configFile.Wsus.IP) -match $pattern)) {
            throw "La syntaxe de l'ip ne correspond pas"
        }
        
    }

    catch {
        throw $PSItem.Exception.Message

    }
    
}

function LettreLecteur {
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "{1}[A-Z]:"
    try { 

        if (!($($configFile.Arborescence.LETTRELECTEUR) -match $pattern)) {
            throw "Le lecteur doit être déclaré sous la forme d'une lettre suivi du caractère :"
        }
        
    }

    catch {
        throw $PSItem.Exception.Message

    }
    
}