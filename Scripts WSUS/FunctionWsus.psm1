function ConfPath
{
    $confPath = "C:\Users\Administrateur\Documents\GitHub\MAJImagesWDS\confWsus.psd1"
    $configFile = Import-PowerShellDataFile -Path $confPath -ErrorAction Stop    
}

function OSVERSION
{
    ConfPath
    $pattern = "^(Windows) (.+)$"

    try 
    { 

        if (!($($configFile.OSVERSION) -match $pattern)) 
        {
            throw "Erreur : Les mises à jour ne peuvent pas être téléchargées pour cet OS. Vérifier la valeur de OSVERSION dans le fichier de configuration."
        }
        
    }

    catch
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function OSARCHITECTURE
{
    ConfPath
    $pattern = "^(x64)$|^(x86)$|^(arm64)$"

    try 
    { 

        if (!($($configFile.OSARCHITECTURE) -match $pattern)) 
        {
            throw "Erreur : Les mises à jour ne peuvent pas être téléchargées pour cette architecture. Vérifier la valeur de OSARCHITECTURE dans le fichier de configuration."
        }
        
    }

    catch
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWsusLETTRELECTEUR 
{
    ConfPath
    $pattern = "^([ABD-Z])(:)$"

    try 
    { 

        if (!($($configFile.ArborescenceWsus.LETTRELECTEUR) -match $pattern)) 
        {
            throw "Erreur : La syntaxe de la lettre de lecteur n'est pas la bonne. Vérifier la valeur de ArborescenceWsus.LETTRELECTEUR dans le fichier de configuration."
        }
        
    }

    catch
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWsusMAJFOLDER
{
    ConfPath
    $pattern = '^(\\)([^<>:“\/\\|?,*\. ]+)(\\)([^<>:“\/\\|?,*\. ]+)$|^(\\)([^<>:“\/\\|?,*\. ]+)$'

    try 
    { 

        if (!($($configFile.ArborescenceWsus.MAJFOLDER) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du dossier contenant les mises à jour téléchargées n'est pas bonne. Vérifier la valeur de Wsus.MAJFOLDER dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWsusMAJEXTENSION
{
    ConfPath
    $pattern = '^(\*\.cab)$|^(\*\.msu)$'

    try 
    {       
        if(!($($configFile.ArborescenceWsus.MAJEXTENSION) -match $pattern))
            {
            throw "Erreur : la syntaxe de l'extension du fichier de mise à jour n'est pas bonne. Vérifier la valeur de ArborescenceWsus.MAJEXTENSION dans le fichier de configuration."
            }
    }

    catch
    { 
            throw $PSItem.Exception.Message + " (Emplacement : $confPath)"
    }
}

function ArborescenceWsusMAJFOLDERSHARE
{
    ConfPath
    $pattern = '^(\\)([^<>:“\/\\|?,*\. ]+)$'

    try 
    { 

        if (!($($configFile.ArborescenceWsus.MAJFOLDERSHARE) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du dossier contenant les fichiers de mises à jour requis par WDS n'est pas bonne. Vérifier la valeur de Wsus.MAJFOLDERSHARE dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWsusLOGPATH
{
    ConfPath
    $pattern = '^([A-Z])(:)(\\)(.+)(\.txt)$'

    try 
    {
        if(!($($configFile.ArborescenceWsus.LOGPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier de log n'est pas bonne. Vérifier la valeur de ArborescenceWsus.LOGPATH dans le fichier de configuration."
        }
               
        if(!(Test-Path -Path ("$($configFile.ArborescenceWsus.LOGPATH)")))
        {
            New-Item -Path ("$($configFile.ArborescenceWsus.LOGPATH)") -ItemType File
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function ArborescenceWsusFONCTIONPATH
{
    ConfPath
    $pattern = '(C:)(\\)(Program Files)(\\)(WindowsPowerShell)(\\)(Modules)(\\)([^<>:“\/\\|?,*\. ]+)(\\)([^<>:“\/\\|?,*\. ]+)(\.psm1)'

    try 
    {
        if (!($($configFile.ArborescenceWsus.FONCTIONPATH) -match $pattern)) 
        {
            throw "Erreur : La syntaxe du chemin menant au fichier module n'est pas bonne. Vérifier la valeur de ArborescenceWsus.FONCTIONPATH dans le fichier de configuration."
        }
        
    }

    catch 
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"

    }
    
}

function TESTSERVICESWSUS
{
    ConfPath   
    try
    {

        if((Get-Service).Name -cnotcontains "WsusService")
            {
            throw "Erreur : Le service WSUS n'est pas installé sur ce serveur."
            }

    }

    catch
    {
        throw $PSItem.Exception.Message + " (Emplacement : $confPath)"
    }

}

function PURGEWSUS
{
$server = 'WSUS-SRV'
$port = '8530'
$WSUSserver = Get-WsusServer -Name $server -PortNumber $port
$approvedupdates = Get-WsusUpdate -UpdateServer $WSUSserver -Approval AnyExceptDeclined -Status Any
$i = 0
$superseded = $approvedupdates | ? {$_.Update.IsSuperseded -eq $true -and $_.ComputersNeedingThisUpdate -eq 0}
$total = $superseded.count
foreach ($update in $superseded)
{
    Write-Progress -Activity 'Declining updates' -Status "$($update.Update.Title)" -PercentComplete (($i/$total) * 100)
    $update.Update.Decline()
    $i++
}
Write-Host "Total declined updates: $total" -ForegroundColor Yellow
Invoke-WsusServerCleanup -CleanupObsoleteUpdate -CleanupUnneededContentFiles -CompressUpdates -DeclineExpiredUpdates -DeclineSupersededUpdates
}