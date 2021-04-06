# Avant de lire les scripts, consulter le PDF [Documentation Technique](https://github.com/Fabien-LB/MAJImagesWDS/blob/main/Documentation%20Technique.pdf)
### *Dernière modification : 6/04/2021*

## Index

- [Introduction](#introduction)
- [Environnement de travail](#environnement-de-travail)
- [Fonctionnement](#fonctionnement)
- [Installation](#installation)

## Introduction

Ce projet a été réalisé, et est présent ici sous sa version finale, durant les mois de Janvier et Février 2021 durant mon stage de deuxième année de BTS SIO.

Le but étant de pouvoir mettre à jour des images de déploiement WDS de manière automatique.

Pour assurer un résultat probant, les scripts du serveur WSUS doivent être lancés en premier et, une fois finis d'exécuter, les scripts du serveur WDS peuvent être lancés.

## Environnement de travail

Ce projet a été réalisé dans un domaine Windows qui comprenait :

- Un contrôleur de domaine AD/DHCP
- Un serveur WDS
- Un serveur WSUS

## Fonctionnement

Le serveur WSUS va servir de « repository » de KB (Knowledge Base) et ainsi stocker (en fonction de la version de l’image que l’on souhaite mettre à jour) les KB dans un fichier local partagé afin que le serveur WDS puisse y accéder.

Le serveur WDS va donc monter l’image Install.wim présente sur son banc de déploiement accéder au partage sur le serveur WSUS et ainsi injecter les KB dans l’image Install.wim.

Une fois cela effectué le poste qui sera déployé avec l’image Install.wim qui aura reçu les KB sera totalement à jour (aucun démarrage requis) et sera à la dernière version de Windows 10


## Installation

Pour bien installer les scripts voir la [Documentation Technique](https://github.com/Fabien-LB/MAJImagesWDS/blob/main/Documentation%20Technique.pdf)
