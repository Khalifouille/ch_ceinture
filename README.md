# Script de gestion de la ceinture de sécurité pour FiveM

Ce script implémente un système de ceinture de sécurité pour les joueurs sur un serveur FiveM. Il permet de contrôler si les joueurs attachent leur ceinture lorsqu'ils sont dans un véhicule et offre des fonctionnalités supplémentaires pour les forces de l'ordre.

## Fonctionnalités

- Les joueurs peuvent attacher ou détacher leur ceinture en utilisant la commande `/ceinture`.
- Si un joueur roule à une vitesse supérieure à 20 km/h sans ceinture, un avertissement sonore est émis après quelques secondes.
- La ceinture se détache automatiquement lorsque le joueur sort du véhicule.
- Les policiers peuvent vérifier l'état de la ceinture d'un joueur à proximité en utilisant la commande `/checkcein [ID du joueur]`.

## Prérequis

- **FiveM** : Ce script est conçu pour fonctionner sur un serveur FiveM.
- **ESX Framework** : Ce script utilise ESX pour la gestion des joueurs et des permissions.

## Installation

1. Clonez ou téléchargez ce dépôt.
2. Placez le dossier dans le répertoire `resources` de votre serveur FiveM.
3. Ajoutez la ressource dans votre fichier `server.cfg` :
4. Redémarrez votre serveur.

## Utilisation

### Commandes disponibles

- `/ceinture` : Attache ou détache la ceinture du joueur.
- `/checkcein [ID du joueur]` : Vérifie l'état de la ceinture d'un joueur (réservé aux policiers).

### Messages affichés

- **Ceinture attachée** : Indique que la ceinture est attachée.
- **Ceinture détachée** : Indique que la ceinture est détachée.
- **Bip bip bip ! Mettez votre ceinture !** : Avertissement sonore pour les joueurs sans ceinture roulant à une vitesse élevée.
- **Ceinture détachée automatiquement** : Indique que la ceinture a été détachée automatiquement lorsque le joueur est sorti du véhicule.

## Fonctionnalité pour les policiers

- Vérifiez si un joueur porte sa ceinture en vous approchant à moins de 3 mètres de lui et en utilisant la commande `/checkcein [ID du joueur]`.

## Contribution

Les contributions sont les bienvenues ! Veuillez soumettre vos suggestions via des issues ou pull requests sur ce dépôt.

## Avertissements

- Ce script nécessite l'intégration avec ESX et ne fonctionnera pas correctement sans lui.
- Assurez-vous que les permissions de commandes sont correctement configurées pour éviter tout abus.
