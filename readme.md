# Ressources pour Ansible

A partir de mai 2023, le pôle plateforme a commencé l'utilisation d'[Ansible] pour l'automatisation de l'administration de ses plateformes Moodle.

Ce dossier contient une démo très épurée et non fonctionnelle donnant un exemple de ce qui a été produit et est suivi en la matière.

## Organisation

### playbooks/

Contient tous les playbooks exécutables par Ansible.

### inventories/

Contient tous les inventaires de serveurs ciblés par les playbooks Ansible

### roles/

Contient tous les rôles Ansible réutilisables par les différents playbooks


## Usages

### Exemples

#### Playbook installation d'un serveur kecampus

Ce playbook, en production, permet l'installation des serveurs web de la plateforme Ecampus sur ses serveurs .

Exemple pour le lancer sur la préprod :

```bash
ansible-playbook -i inventories/serveurs_pp.yml <options pour vault...> playbooks/installation_serveurs_kecampus.yaml
```
