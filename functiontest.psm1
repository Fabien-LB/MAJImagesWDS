function ArborescenceLETTRELECTEUR 
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "^([A-Z]){1}(:)$"
    try 
    { 

        if (!($($configFile.Arborescence.LETTRELECTEUR) -match $pattern)) 
        {
            throw "Erreur : La syntaxe de la lettre de lecteur n'est pas la bonne"
        }
        
    }

    catch
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceMONTAGE
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)([^<>":\/\\|?,*\. ]+)$'
    try 
    { 

        if (!($($configFile.Arborescence.MONTAGE -match $pattern)))
        {
            throw "Erreur : La syntaxe du chemin vers le dossier de montage n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceUPDATES
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)([^<>":\/\\|?,*\. ]+)$'
    try 
    { 

        if (!($($configFile.Arborescence.UPDATES -match $pattern)))
        {
            throw "Erreur : La syntaxe du chemin vers le dossier contenant les mises à jour n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceSOURCES
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)([^<>":\/\\|?,*\. ]+)$'
    try 
    { 

        if (!($($configFile.Arborescence.SOURCES -match $pattern)))
        {
            throw "Erreur : La syntaxe du chemin menant au dossier contenant l'image install.wim n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceISOINSTALLWIM
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "\sources\install.wim"
    try 
    { 

        if (!($($configFile.Arborescence.ISOINSTALLWIM) -like $pattern)) 
        {
            throw "Erreur : la syntaxe du chemin de l'install.wim contenue dans l'image ISO n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceINSTALLWIM
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)([^<>":\/\\|?,*\. ]+)(\\)(install\.wim)$'
    try 
    { 

        if (!($($configFile.Arborescence.INSTALLWIM) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier install.wim n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceISOPATH
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)(.+)(\.iso)$'
    try 
    { 

        if (!($($configFile.Arborescence.ISOPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin vers l'image ISO n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function ArborescenceFONCTIONPATH
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = '(C:)(\\)(Program Files)(\\)(WindowsPowerShell)(\\)(Modules)(\\)([^<>:“\/\\|?,*\. ]+)(\\)([^<>:“\/\\|?,*\. ]+)(\.psm1)'
    try 
    {
        if (!($($configFile.Arborescence.FONCTIONPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier module n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function WsusIP 
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    try { 
          if (!($($configFile.Wsus.IP) -match $pattern)) 
          {
                throw "Erreur : La syntaxe de l'adresse IP du serveur WSUS n'est pas bonne"
          }
    }

    catch {
        throw $PSItem.Exception.Message

    }
    
}

function WsusPARTAGEPATH
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "\WsusContent"
    try 
    { 

        if (!($($configFile.Wsus.PARTAGEPATH) -like $pattern)) 
        {
            throw "Erreur : La syntaxe du dossier contenant les mises à jour sur le serveur WSUS n'est pas bonne"
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message

    }
    
}

function WsusEXTENSIONFICHIER
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = ".\*.cab"
    try {
        if(!($($configFile.Wsus.EXTENSIONFICHIER) -like $pattern))
            {
            throw "Erreur : la syntaxe de l'extension du fichier de mise à jour n'est pas la bonne"
            }
        }
     catch
        { 
            throw $PSItem.Exception.Message  
        }
}

function WDSGROUPEIMAGE
{
        try 
    { 
        $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
            if(!(Test-Path -Path "$($configFile.Arborescence.LETTRELECTEUR)\RemoteInstall\Images\$($configFile.WDSGROUPIMAGE)")) 
        {
                 wdsutil /Verbose /add-ImageGroup /imageGroup:"$($configFile.WDSGROUPIMAGE)"
        }
            else
        {
                 throw "Erreur : un groupe d'image possède déjà ce nom"
        }
        
    }

        catch 
    {
                throw $PSItem.Exception.Message
    }
}