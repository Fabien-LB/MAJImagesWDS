function ConfPath
{
    $confPath = "C:\scripts\Conf.psd1"
    $configFile = Import-PowerShellDataFile -Path $confPath -ErrorAction Stop
}

function ArborescenceWdsLETTRELECTEUR 
{
    ConfPath
    $pattern = "^([ABD-Z])(:)$"

    try 
    { 

        if (!($($configFile.ArborescenceWds.LETTRELECTEUR) -match $pattern)) 
        {
            throw "Erreur : La syntaxe de la lettre de lecteur n'est pas la bonne. Vérifier la valeur de ArborescenceWds.LETTRELECTEUR dans le fichier de configuration."
        }
        
    }

    catch
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWdsMONTAGE
{
    ConfPath
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)'

    try 
    { 

        if (!($($configFile.ArborescenceWds.MONTAGE -match $pattern)))
        {
            throw "Erreur : La syntaxe du chemin vers le dossier de montage n'est pas bonne. Vérifier la valeur de ArborescenceWds.MONTAGE dans le fichier de configuration."
        }

        if(!(Test-Path -Path ("$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.MONTAGE)")))
        {
            New-Item -Path ("$($configFile.ArborescenceWds.LETTRELECTEUR)$($configFile.ArborescenceWds.MONTAGE)") -ItemType Directory
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWdsINSTALLWIM
{
    ConfPath
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)(install\.wim)$|^(\\)(install\.wim)$'

    try
    { 

        if (!($($configFile.ArborescenceWds.INSTALLWIM) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier install.wim n'est pas bonne. Vérifier la valeur de ArborescenceWds.INSTALLWIM dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWdsISOINSTALLWIM
{
    ConfPath
    $pattern = "\sources\install.wim"

    try 
    { 

        if (!($($configFile.ArborescenceWds.ISOINSTALLWIM) -like $pattern)) 
        {
            throw "Erreur : la syntaxe du chemin de l'install.wim contenue dans l'image ISO n'est pas bonne. Vérifier la valeur de ArborescenceWds.ISOINSTALLWIM dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWdsISOPATH
{
    ConfPath
    $pattern = '^(\\)([^<>":\/\\|?,*\. ]+)(\\)(.+)(\.iso)$'
    try 
    { 

        if (!($($configFile.ArborescenceWds.ISOPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin vers l'image ISO n'est pas bonne. Vérifier la valeur de ArborescenceWds.ISOPATH dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWdsFONCTIONPATH
{
    ConfPath
    $pattern = '(C:)(\\)(Program Files)(\\)(WindowsPowerShell)(\\)(Modules)(\\)([^<>:“\/\\|?,*\. ]+)(\\)([^<>:“\/\\|?,*\. ]+)(\.psm1)'

    try 
    {
        if (!($($configFile.ArborescenceWds.FONCTIONPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier module n'est pas bonne. Vérifier la valeur de ArborescenceWds.FONCTIONPATH dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWdsLOGPATH
{
    ConfPath
    $pattern = '^([A-Z])(:)(\\)(.+)(\.txt)$'

    try 
    {
        if (!($($configFile.ArborescenceWds.LOGPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier de log n'est pas bonne. Vérifier la valeur de ArborescenceWds.LOGPATH dans le fichier de configuration."
        }
               
        if(!(Test-Path -Path ("$($configFile.ArborescenceWds.LOGPATH)")))
        {
            New-Item -Path ("$($configFile.ArborescenceWds.LOGPATH)") -ItemType File
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function WsusIP 
{
    ConfPath
    $pattern = '^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

    try { 
          if (!($($configFile.Wsus.IP) -match $pattern)) 
          {
                throw "Erreur : La syntaxe de l'adresse IP du serveur WSUS n'est pas bonne. Vérifier la valeur de Wsus.IP dans le fichier de configuration."
          }
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function WsusMAJFOLDER
{
    ConfPath
    $pattern = '^(\\)([^<>:“\/\\|?,*\. ]+)$'
    try 
    { 

        if (!($($configFile.Wsus.MAJFOLDER) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du dossier contenant les dossiers de mises à jour sur le serveur WSUS n'est pas bonne. Vérifier la valeur de Wsus.MAJFOLDER dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function WsusMAJPATH
{
    ConfPath
    $pattern = '^(\\)([^<>:“\/\\|?,*\. ]+)$'
    try 
    {       
        if(!($($configFile.Wsus.MAJPATH) -match $pattern))
            {
            throw "Erreur : la syntaxe du dossier contenant les fichiers de mises à jour (.cab et .msu) n'est pas bonne. Vérifier la valeur de Wsus.MAJFOLDERSHARE dans le fichier de configuration. "
            }
    }

    catch
    { 
            throw $PSItem.Exception.Message + " (Emplacement : $confPath)"
    }
}

function WDSGROUPEIMAGE
{
    ConfPath   
    try 

    { 
        
            if(!(Test-Path -Path "$($configFile.WDSGROUPEIMAGEPATH)\Images\$($configFile.WDSGROUPIMAGE)")) 
        {
                 wdsutil /Verbose /add-ImageGroup /imageGroup:"$($configFile.WDSGROUPIMAGE)"
        }
            else
        {
                 throw "Erreur : Un groupe d'image possède déjà ce nom. Vérifier la valeur de WDSGROUPEIMAGE dans le fichier de configuration."
        }
        
    }

        catch 
    {
                throw $PSItem.Exception.Message + " (Emplacement : $confPath)"
    }
}

function WDSGROUPEIMAGEPATH
{
    ConfPath
    $pattern = '^([ABD-Z])(:)(\\)([^<>":\/\\|?,*\. ]+)$'

        try 
    { 
        if (!($($configFile.WDSGROUPEIMAGEPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du dossier contenant les groupes d'images n'est pas bonne. Vérifier la valeur de WDSGROUPEIMAGEPATH dans le fichier de configuration."
        }
            
        
    }

        catch 
    {
                throw $PSItem.Exception.Message + " (Emplacement : $confPath)"
    }
}

function TESTSERVICESWDS
{
    ConfPath
    try

    {       
        if((Get-Service).Name -cnotcontains "WDSServer" )
            {
            throw "Erreur : Le service WDS n'est pas installé sur ce serveur. "
            }
    }

    catch
    { 
        throw $PSItem.Exception.Message          
    }
}