@{
        
        # TOUTES LES CONSTANTES DÉCLARÉES DANS CE FICHIER SONT SENSIBLES À LA CASSE
            
        OSVERSION = "Windows 10"
<#      Définit pour quelles versions de Windows les mises à jour doivent être téléchargées
        Doit commencer obligatoirement par la chaîne de caractère "Windows"
#> 
        OSARCHITECTURE = "x64"
<#      Définit pour quelles types d'architecture Windows les mises à jour doivent être téléchargées
        Seuls les trois types d'architecture suivant sont reconnus et doivent être écrit comme cela : "x64" "x86" "arm64"
#>    

        ArborescenceWsus = @{

        LETTRELECTEUR = "E:"
<#      Lettre du lecteur où l'arborescence va se situer
        Doit obligatoirement être une LETTRE suivi du caractère : (Exemple A: D: etc)
        La lettre C est exclu pour éviter de manipuler les images sur la partition système
#>

        MAJFOLDER = "\WsusServer\WsusContent"
<#      Emplacement du dossier qui stocke les mises à jour téléchargées, le nom de base de ce dossier lors de l'installation de WSUS est "WsusContent"
        Doit obligatoirement commencer par une barre oblique inversée (\)
        Si un dossier racine a été spécifié lors de l'installation de WSUS il doit être rensigné ici
#>

        MAJEXTENSION = "*.cab"
<#      Désigne l'extension de mises à jour que l'on souhaite appliquer aux images d'installation
        Doit obligatoirement commencer par un asterisk (*) suivi d'une extension valide (.cab ou .msu)      
#>

        MAJFOLDERSHARE = "\WsusPartage"
<#      Dossier où WDS vient prendre les mises à jour pour les injecter aux images
        Un seul dossier doit être spécifié, doit obligatoirement commencer par une barre oblique inversée (\)
        Le nom du dossier doit être le même que celui renseigné dans la constante Wsus.MAJFOLDERSHARE du fichier de configuration du serveur WDS
#>

        LOGPATH = "E:\WsusLog.txt"
<#      Chemin d'accès menant au fichier de log, recensant toute les erreurs liées à l'éxécution du script WSUS
        Doit obligatoirement commencer par une lettre de lecteur ET avoir finir par un fichier en extension .txt 
#>

        FONCTIONPATH = "C:\Program Files\WindowsPowerShell\Modules\FunctionWsus\FunctionWsus.psm1"
<#      Chemin menant au fichier module (d'extension .psm1) contenant les fonctions
        La chaîne de caractère suivante est toujours placée au début et ne doit être changée: "C:\Program Files\WindowsPowerShell\Modules\". Elle correspond au chemin de stockage par défaut des fichiers modules PowerShell (.psm1)
        Le dossier contenant le fichier module doit avoir le même nom que le fichier module (extension non incluse)
#>

                            }
     
}