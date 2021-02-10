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
        # Doit obligatoirement être une LETTRE suivi du caractère : (Exemple A: C: D: etc). N'est pas sensible à la casse

        MONTAGE = "\Atelier\Mount"
        # Dossier servant à monter l'image
        # Doit obligatoirement commencer par une barre oblique inversée (\) et contenir EXACTEMENT le nom de 2 dossiers

        UPDATES = "\Atelier\Updates"
        # Dossier servant au stockage des mises à jour
        # Doit obligatoirement commencer par une barre oblique inversée (\) et contenir EXACTEMENT le nom de 2 dossiers

        SOURCES = "\Atelier\Sources"
        # Dossier servant au stockage du fichier install.wim
        # Doit obligatoirement commencer par une barre oblique inversée (\) et contenir EXACTEMENT le nom de 2 dossiers

        ISOINSTALLWIM = "\sources\install.wim"
        # Dossier comprenant le fichier install.wim dans une image ISO.
        # Doit obligatoirement commencer par une barre oblique inversée (\)
        # Le fichier install.wim est toujours stocké au même endroit dans une image ISO, la syntaxe ne doit donc pas être changée

        INSTALLWIM = "\Atelier\sources\install.wim"
        # Chemin menant au fichier install.wim
        # Doit obligatoirement commencer par une barre oblique inversée (\) et contenir EXACTEMENT le nom de 2 dossiers PLUS la chaîne de caractère suivante: \install.wim

        ISOPATH = "\ImagesWindows10\W10\Win10_2004_French_x64.iso"
        # Chemin menant à l'image ISO qui souhaite être déployée
        # Doit obligatoirement commencer par une barre oblique inversée (\) et contenir AU MINIMUM le nom d'un dossier ET doit avoir à la fin une extension en .iso 

        FONCTIONPATH = "C:\Program Files\WindowsPowerShell\Modules\functiontest\functiontest.psm1"
        # Chemin menant au fichier module (d'extension .psm1) contenant les fonctions
        # La chaîne de caractère suivante est toujours placée au début et ne doit être changée: "C:\Program Files\WindowsPowerShell\Modules\"
        # Le dossier contenant le fichier module doit avoir le même nom que le fichier module (extension non incluse)         
                        }

        Wsus = @{
        # Le script récupère les mises à jour sur un serveur WSUS distant où un partage aura au préalable été monté

        IP  = "192.168.12.108"
        # Adresse IP du serveur WSUS
        # Doit respecter le format d'une adresse IPV4

        PARTAGEPATH = "\WsusContent"
        # Dossier sur le serveur WSUS qui stocke les mises à jour
        # Doit obligatoirement commencer par une barre oblique inversée (\), ce dossier ayant toujours le même nom lors de la création de WSUS, il n'a pas vocation à être modifié

        EXTENSIONFICHIER = ".\*.cab"
        # Extension des fichiers de mises à jour
        # Doit toujours commencer par la chaîne de caractère suivante: .\*.
        # Les seules types de fichiers de mises à jour téléchargés par WSUS et applicable dans une image install.wim sont les .cab. L'extension ne doit donc pas être modifiée

                 }

        WDSGROUPIMAGE = "abc"
        # Définit le nom du groupe d'image WDS qui recevra les images du fichier install.wim
        # Attention à ne pas renseigner le nom d'un groupe d'images WDS déjà existant
         
}