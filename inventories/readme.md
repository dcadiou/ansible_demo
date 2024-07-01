# Rappels

Les fichiers d'inventaires Ansible sont, en plus du reste, un bon moyen de définir des variables attachées à tel ou tel serveur (`host`) ou groupe de serveurs (`group`).

Le présent projet en fait un usage intensif.

De nombreuses variables doivent y être configurées, car elles sont utilisées par les playbooks. Quand un nouveau serveur est ajouté à l'inventaire, **il faut vérifier que toutes les variables l concernant sont bien définies** soit directement pour lui-même ou pour un groupe auquel il appartient (auquel cas elles n'ont pas nécessairement besoin d'être redéfinies).

Voir le readme listant toutes [les variables à configurer](readme_variables.md).

Ce projet contient différents groupes de serveurs plus ou moins imbriqués en fonction de leur nature (serveurs web, de BD, etc), de la plateforme concernée (Moodle pour Ecampus, Collegium, etc) afin d'éviter autant que possible d'avoir des définitions de variables redondantes.

Voir le readme décrivant [les groupes créés](readme_groupes.md).
