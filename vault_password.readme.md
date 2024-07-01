# Mot de passe de la Vault Ansible

[TOC]

**C'EST UNE INFORMATION SENSIBLE** qui permet l'encryptage, mais surtout le décryptage de toutes les données sensibles qui ne doivent surtout pas être divulguées dans le contrôle de révision (Git).

Les données sensibles, par exemple le contenu de `vars/sensitive.yml`, sont encryptées par Ansible et suivies sous contrôle de révision dans leur version encryptées, **et uniquement dans cette version encryptées**.

**Les données sensibles ne doivent JAMAIS être sous contrôle de révision (Git) EN CLAIR**


## Usage

Voir https://docs.ansible.com/ansible/latest/vault_guide/index.html

### Vérifications

Pour vérifier qu'un fichier est bien encrypté, sa première ligne doit contenir quelque chose qui ressemble à ça
```
$ANSIBLE_VAULT;1.1;AES256
```

### Modification du mot de passe de la vault

*A documenter...*

Voir commande `ansible-vault rekey`.

**Attention !** si ce mot de passe est modifié, il faut propager cette modification au contenu déjà encryptés sinon ils ne seront plus accessibles avec le nouveau mot de passe.

### Références à la vault dans un playbook

Voir la documentation.

### Encryptage d'un fichier

Exemple pour encrypter le fichier `toto.txt`
```bash
ansible-vault encrypt <options choisies...> toto.txt
```

Recommandations : respecter cette [règle](https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html#keep-vaulted-variables-safely-visible) et essayer de maintenir 2 versions des fichiers de variables encryptés.

* Une en clair (dans un dossier `vars/` par exemple) qui contient les variables avec leur nom lisible, mais la valeur qui fait référence à celle de leur "soeur" cryptée
* une cryptée (dans un dossier `vault/` par exemple) qui contient les variables cryptée.

### Visualisation d'un fichier encryptées

Exemple pour visualiser le contenu de `playbooks/vault/sensitive.yml`
```bash
ansible-vault view <options choisies...> playbooks/vault/sensitive.yml
```

### Modification d'un fichier encrypté

Exemple pour visualiser le contenu de `playbooks/vault/sensitive.yml`

1. `ansible-vault edit <options choisies...> playbooks/vault/sensitive.yml`
2. modifier le fichier et le sauver avec l'éditeur qui s'ouvre (éditeur par défaut du système).

Attention ! l'éditeur utilisé peut lui-même être une source de divulgation de données (pour qui aurait accès au poste local utilisé pour éditer le fichier encrypté). Voir https://docs.ansible.com/ansible/latest/vault_guide/vault_encrypting_content.html#steps-to-secure-your-editor
