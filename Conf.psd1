@{

        WDSGROUPIMAGE = "abc"
        # Définit le nom du groupe d'image WDS qui recevra les images du fichier install.wim

        Arborescence = @{
        <# Pour fonctionner, le script a besoin d'une arborescence composée d'une lettre de lecteur, avec à sa racine deux dossiers : 
        - L'un comprenant le stockage des images ISO
        - L'autre comprenant au minimum 3 sous-dossiers : - Un pour le stockage des mises à jour, 
                                                          - Un pour le stockage du fichier install.wim
                                                          - Un dernier pour monter l'image 
        #>

        LETTRELECTEUR = "aa:"
        # Lettre du lecteur où l'arborescence doit se située

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

        CHEMINISO = "\ImagesWindows10\W10\Win10_2004_French_x64.iso"
        # Chemin menant à l'image ISO qui souhaite être déployée

                        }

        Wsus = @{
        # Le script récupère les mises à jour sur un serveur WSUS distant où un partage aura au préalable été monté
    
        #Nom = "WSUS-SRV"

        IP  = "192.168.12.108"
        # Adresse IP du serveur WSUS

        CHEMINPARTAGE = "\WsusContent"
        # Dossier sur le serveur WSUS qui stocke les mises à jour

        EXTENSIONFICHIER = ".\*.cab"
        # Extension des fichiers de mises à jour

                 }

         
}