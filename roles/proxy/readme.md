## Couverture de la définition des proxy

La gestion actuelle des proxy permet

* de gérer
    * les variables d'environnement pour l'utilisateur root (mais pas en sudo)
    * la config proxy d'APT
* **Ne prends pas en charge**
    * les variables d'environnement pour l'utilisateur courant (connecté au travers de SSH)
* impose de gérer par ailleurs
    * la config proxy de Git (gérée dans le rôle `install_git`)
    * les besoins ponctuels des différentes taches Ansible.

## Besoins ponctuels des différentes taches Ansible

### Au niveau de la tache

Chaque tache qui a besoin d'un accès extérieur doit définir ponctuellement ses variables d'environnement, comme le fait par exemple la tache `oci8, téléchargement` :

```yaml
    - name: oci8, téléchargement
      ansible.builtin.get_url:
        ...
      environment:
        - http_proxy: '{{proxy}}'
        - https_proxy: '{{proxy}}'
```
