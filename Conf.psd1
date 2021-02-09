# IMPORTANT : La varialble contenant le chemin d'accès à ce fichier se trouve dans le script principal
@{

        Arborescence = @{
        <# Pour fonctionner, le script a besoin d'une arborescence composée d'une lettre de lecteur, avec à sa racine deux dossiers : 
        - L'un comprenant le stockage des images ISO
        - L'autre comprenant au minimum 3 sous-dossiers : - Un pour le stockage des mises à jour, 
                                                          - Un pour le stockage du fichier install.wim
                                                          - Un dernier pour monter l'image 
        #>

        LETTRELECTEUR = "D:"
        # Lettre du lecteur où l'arborescence doit se située
        # Doit obligatoirement être une MAJUSCULE suivi du caractère :
        # Exemple A: C: D: etc 

        MONTAGE = "\Atelier\Mount"
        # Dossier servant à monter l'image

        UPDATES = "\Atelier\Updates"
        # Dossier servant au stockage des mises à jour

        SOURCES = "\Atelier\Sources"
        # Dossier servant au stockage du fichier install.wim

        ISOINSTALLWIM = "\sources\install.wim"
        # Dossier comprenant le fichier install.wim dans une image ISO. Ce dossier est en général toujours le même peut importe l'image ISO

        INSTALLWIM = "\Atelier\sources\install.wim"
        # Chemin menant au fichier install.wim

        ISOPATH = "\ImagesWindows10\W10\Win10_2004_French_x64.iso"
        # Chemin menant à l'image ISO qui souhaite être déployée

        FONCTIONPATH = "C:\Users\Administrateur\Documents\WindowsPowerShell\Modules\functiontest\functiontest.psm1"
        # Chemin menant au fichier module (d'extension .psm1) contenant les fonctions
                        
                        }

        Wsus = @{
        # Le script récupère les mises à jour sur un serveur WSUS distant où un partage aura au préalable été monté

        IP  = "192.168.12.108"
        # Adresse IP du serveur WSUS

        PARTAGEPATH = "\WsusContent"
        # Dossier sur le serveur WSUS qui stocke les mises à jour

        EXTENSIONFICHIER = ".\*.cab"
        # Extension des fichiers de mises à jour

                 }

        WDSGROUPIMAGE = "abc"
        # Définit le nom du groupe d'image WDS qui recevra les images du fichier install.wim
         
}