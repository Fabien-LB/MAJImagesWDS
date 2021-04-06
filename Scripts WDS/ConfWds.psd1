# IMPORTANT : La varialble contenant le chemin d'accès à ce fichier se trouve dans le script principal
@{

        # TOUTES LES CONSTANTES DÉCLARÉES DANS CE FICHIER SONT SENSIBLES À LA CASSE

        ArborescenceWds = @{
        # Pour fonctionner, le script a besoin d'une partition avec une lettre de lecteur, autre que C:, contenant au minimum une image ISO d'un système d'exploitation Windows 

        LETTRELECTEUR = "D:"
<#      Lettre du lecteur où l'arborescence va se situer
        Doit obligatoirement être une LETTRE suivi du caractère : (Exemple A: D: etc)
        La lettre C est exclu pour éviter de manipuler les images sur la partition système
#>
        MONTAGE = "\Mount"
<#      Dossier(s) servant à monter l'image
        Doit obligatoirement commencer par une barre oblique inversée (\)
        IMPORTANT : Le chemin est détruit après utilisation, il n'est donc pas permanent sur l'arborescence
#>        
        INSTALLWIM = "\install.wim"
<#      Chemin menant au fichier install.wim. Le fichier peut être placé à la racine du lecteur ou dans des dossiers
        Doit obligatoirement commencer par une barre oblique inversée (\)
        IMPORTANT : Le chemin, et/ou le fichier, est détruit après utilisation, il n'est donc pas permanent sur l'arborescence
#> 
        ISOINSTALLWIM = "\sources\install.wim"
<#      Dossier comprenant le fichier install.wim dans une image ISO.
        Doit obligatoirement commencer par une barre oblique inversée (\)
        Le fichier install.wim est toujours stocké au même endroit dans une image ISO, sauf cas particulier, cette constante ne doit pas être changée
#>
        ISOPATH = "\ImagesWindows10\W10\Win10_2004_French_x64.iso"
<#      Chemin d'accès à l'image ISO qui souhaite être déployée
        Doit obligatoirement commencer par une barre oblique inversée (\) et contenir AU MINIMUM un dossier ET doit avoir à la fin une extension en .iso 
#>
        FONCTIONPATH = "C:\Program Files\WindowsPowerShell\Modules\functionWds\functionWds.psm1"
<#      Chemin menant au fichier module (d'extension .psm1) contenant les fonctions
        La chaîne de caractère suivante est toujours placée au début et ne doit être changée: "C:\Program Files\WindowsPowerShell\Modules\". Elle correspond au chemin de stockage par défaut des fichiers modules PowerShell (.psm1)
        Le dossier contenant le fichier module doit avoir le même nom que le fichier module (extension non incluse) 
#>
        LOGPATH = "D:\WdsLog.txt"
<#      Chemin d'accès menant au fichier de log, recensant toute les erreurs liées à l'éxécution du script WDS
        Doit obligatoirement commencer par une lettre de lecteur ET avoir finir par un fichier en extension .txt 
#>                
                          }

        Wsus = @{
        # Le script récupère les mises à jour sur un serveur WSUS distant où un partage aura au préalable été monté

        IP  = "192.168.12.108"
<#      Adresse IP du serveur WSUS
        Doit respecter le format d'une adresse IPV4
#>
        MAJFOLDER = "\WsusContent"
<#      Dossier sur le serveur WSUS qui stocke les mises à jour téléchargées, le nom de base de ce dossier lors de l'installation de WSUS est "WsusContent"
        UN seul dossier doit être spécifié, doit obligatoirement commencer par une barre oblique inversée (\)
        
#>
        MAJFOLDERSHARE = "\WsusPartage"
<#      Contient les fichiers de mises à jour (.cab ou .msu) qui seront injectés dans les images
        UN seul dossier doit être spécifié, doit obligatoirement commencer par une barre oblique inversée (\)  
        Le nom du dossier doit être exactement le même que celui précisé dans la constante ArborescenceWsus.MAJFOLDERSHARE du fichier de configuration du serveur WSUS
#>
                }

        WDSGROUPIMAGE = "Test Final"
<#      Définit le nom du groupe d'image WDS qui recevra les images du fichier install.wim
        Ne peut pas être un nom déjà existant
#>

        WDSGROUPEIMAGEPATH = "D:\RemoteInstall"
<#
        Chemin menant au dossier contenant les groupes d'images du serveur WDS
        Doit commencer par une lettre de lecteur valide autre que C: et être suivit d'UN SEUL dossier
        La lettre de lecteur et le dossier spécifié doivent être les mêmes que ceux renseignés lors de l'installation de WDS
#>
}