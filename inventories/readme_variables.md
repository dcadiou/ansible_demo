# Variables à renseigner dans les fichiers d'inventaire

Certaines variables sont comprises et documentées par Ansible (exemple, `ansible_connection`, `ansible_host`, `ansible_become`, etc).

Ne sont décrites ici que les variables ajoutés dans notre projet Ansible local.

## Localisation des Variables

Les variables sont soit définies

* dans un fichier du sous-dossier `vars/` pour les variables **réellement** communes à tous les playbooks/roles.
* dans chacun des fichiers d'inventaire à la racine (`inventories/serveurs_xxxx.yml`), quand elles ont des valeurs courtes et attachées à un contexte donné (prod, préprod, etc). Voir
  * [serveurs_prod.yml](serveurs_prod.yml) pour les serveurs/plateformes en production
  * [serveurs_pp.yml](serveurs_pp.yml) pour les serveurs/plateformes de préproduction
  * [serveurs_dev.yml](serveurs_dev.yml) pour les serveurs/plateformes de test ou de développement
  * [serveurs_locaux.yml](serveurs_locaux.yml) pour les serveurs/plateformes de test ou de développement locaux (sur le poste de l'utilisateur)
* dans des fichiers yaml dans le dossier `group_vars/nom_du_groupe`, quand les valeurs sont plus nombreuses ou complexes (configs Moodle, fichiers, valeur multilignes, etc). Voir, par exemple, [group_vars/moodle/](group_vars/moodle/ pour les variables qui s'appliquent à tout host ayant pour ancètre le groupe `moodle`.

**Attention !** les variables définies dans `group_vars/` sont communes à tout les fichiers d'inventaires qui contiennent les groupes concernés.

**Note**

* les variables définies dans les fichiers d'inventaires à la racine sont décrites et testées dans le playbook `playbooks/check_inventory.yml`.

## Variables sans valeur

Certaines variables sont efficientes juste en étant définie ou pas. Quand elles sont définies, elles n'ont pas besoin de valeur.

exemple
```yaml
vars:
  - prod:
```
