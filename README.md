# c_simple_event
INSTALLATION :

[1] = Glissez 'swt_notifications' et 'c_simple_event' dans vos resources
[2] = Injectez, dans votre base de données, la requête suivante :

si vous utilisez 'limit' :

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('gold', 'Pépite d\'or', 100, 0, 1);

si vous utilisez 'weight' :

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('gold', 'Pépite d\'or', 10, 0, 1);

[3] = Ajoutez le start des resources, comme ceci :

ensure swt_notifications
ensure c_simple_event

[4] = Démarrez votre serveur

CONFIGURATION :

/server : 

Pour retirer le lancement automatique de l'event, modifiez la ligne 14 dans c_simple_event/server.lua (=true lancement automatique activé, =false lancement automatique désactivé)
Pour changer le temps entre chaque events, modifiez la ligne 15 dans c_simple_event/server.lua (120*60000 = 120 fois* 1 minute = 2 heures)
Pour changer la durée de l'event, modifiez la ligne 16 dans c_simple_event/server.lua (30*6000 = 30 fois* 1 minute = 30 minutes)

/client :

Pour modifier le texte de la vente, modifiez la ligne 55 dans c_simple_event/client.lua (les \n signifient le saut d'une ligne)
Pour modifier le ped de la vente, modifiez la ligne 81 et 86 dans c_simple_event/client.lua (il suffit de changer "csb_abigail" Liste : https://docs.fivem.net/docs/game-references/ped-models/)

Discord CONFIDENTIAL : https://discord.gg/kwy3pPFwJz

Bug connu : si le joueur se connecte pendant que l'event est en cours, il n'y aura pas accès et devra attendre l'event suivant.
