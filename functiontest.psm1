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
                 throw "Un groupe d'image possède déjà ce nom"
        }
        
    }

        catch 
    {
                throw $PSItem.Exception.Message
    }
}

function ArborescenceLETTRELECTEUR 
{
    $configFile = Import-PowerShellDataFile -Path "C:\scripts\Conf.psd1" -ErrorAction Stop
    $pattern = "^([A-Z]){1}:$"
    try 
    { 

        if (!($($configFile.Arborescence.LETTRELECTEUR) -match $pattern)) 
        {
            throw "Le lecteur doit être déclaré sous la forme d'une lettre suivi du caractère :"
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
    $pattern = "^(\\)."
    try 
    { 

        if (!($($configFile.Arborescence.MONTAGE -match $pattern)))
        {
            throw "pas bon"
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
    $pattern = "^(\\)."
    try 
    { 

        if (!($($configFile.Arborescence.UPDATES -match $pattern)))
        {
            throw "pas bon"
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
    $pattern = "^(\\)."
    try 
    { 

        if (!($($configFile.Arborescence.SOURCES -match $pattern)))
        {
            throw "pas bon"
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
    $pattern = "\.wim"
    try 
    { 

        if (!($($configFile.Arborescence.ISOINSTALLWIM) -match $pattern)) 
        {
            throw "pas bon"
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
    $pattern = "\.wim"
    try 
    { 

        if (!($($configFile.Arborescence.INSTALLWIM) -match $pattern)) 
        {
            throw "pas bon"
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
    $pattern = "\.iso"
    try 
    { 

        if (!($($configFile.Arborescence.ISOPATH) -match $pattern)) 
        {
            throw "pas bon"
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
    $pattern = "(C:)(\\)(Users)(\\)(.+)(\\)(Documents)(\\)(WindowsPowerShell)(\\)(Modules)(\\)(.+)(\\)(.+)(\.psm1)"
    try 
    {
        if (!($($configFile.Arborescence.FONCTIONPATH) -match $pattern)) 
        {
            throw "pas bon"
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
                throw "La syntaxe de l'ip ne correspond pas"
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
            throw "pas bon "
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
            throw "L'extension du fichier n'est pas la bonne"
            }
        }
     catch
        { 
            throw $PSItem.Exception.Message  
        }
}