# Description des fichiers de configs applicatives

## Principe

Le fichier `core.yml` liste tous les points de configuration applicatif (in fine stockés dans la table `prefixeMoodle_config`), hors plugins qu'ils soient additionnels ou natifs (intégrés avec le coeur). Pour les points qui concernent des plugins, voir donc le [readme concerné](../plugins/configs/readme.md).

## Nom de la liste de points

Dans ce fichier on doit avoir une liste nommée `configs_core` possédant une collection de dictionnaires, à raison d'un dictionnaire par point de config.

## Points de configuration

Un point de config est un dictionnaire qui peut contenir

```yaml
  - name: # le nom du point de config
    to_be_ignored: # (optionnel) true pour indiquer qu'il s'agit d'une valeur qu'Ansible doit ignorer, par exemple pour des valeurs temporaires, dates ou autres
    default: # sa valeur par défaut
    value: # (optionnel) sa valeur
      # peut-être
      #   * absente = pas d'attribut 'value:' indique que c'est la valeur par défaut qui s'applique (autrement dit pas de configuration explicite)
      #   * '{{le nom d'une variable}}' = pour avoir une définition dynamique de la valeur
      #   * '{{le nom d'une variable cryptée}}' = pour ne pas divulguer des données sensibles
      #   * une valeur avec un '#', comme un code couleur par exemple. L'inscrire entre "'".
      #   * multivaluée = quand la valeur est une liste de valeurs, à exprimer tel que Moodle les stocke en base (strings séparées par des espaces, des virgules ou autres séparateurs. Peut varier d'un plugin à l'autre)
      #   * un ou plusieurs fichiers = un ou plusieurs noms de fichiers (chemin Moodle compris).
      #   Pour les fichiers, l'attribut 'files' ci-après est OBLIGATOIRE.
      # Note : pour les valeurs avec au moins un saut de ligne (valeur multilignes),
      #   ne surtout pas définir 'value:', mais 'external_value:' (voir issue #63)
    external_value: # (optionnel) le chemin (depuis le fichier de config) vers le fichier texte qui contient la valeur.
      # Il est recommandé de placer le fichier texte dans le sous-dossier `external_values/`.
      # Quand `external_value` est utilisé, `value` doit disparaitre.
    files: # (optionnel) liste de 1 à n fichiers (chaque fichier commence par 1 seul ' - ') si la valeur ci-avant designe 1 à n fichiers
      - filename: # le nom du fichier (extension y-compris).
          # Ajouter une extension `.j2` si le fichier contient des expression Jinja à traiter avant utilisation.
        filepath: # son chemin tel que considéré par Moodle
        contextid: # l'id du contexte concerné par ce point de config ('1' pour système)
      - filename: #...
        # ...
    filearea: # (optionnel) si l'attribut `files` est définit, les données enregistrées
      # permettent de lancer la création des fichiers concernés, dans le système de fichier Moodle.
      # L'attribut `name` est généralement utilisé pour renseigner le 'filearea',
      # mais pour certains rares points de configuration, les 2 diffèrent.
      # Dans ce cas, il est possible d'ajouter cet attribut pour renseigner la valeur à utiliser comme 'filearea'.
    plateformes: # (optionnel) la liste des plateformes concernées, si la valeur dépend d'elles
      # - plateforme 1
      # - plateforme 1
```

## Localisation des fichiers à déposer sur la version_cible

Comme évoqué ci-dessus, si un point de configuration possède un attribut `files`, il décrit un ensemble de fichiers à déposer dans le système de fichiers Moodle de la cible (hashés dans le dataroot).

Cette description va donc faire référence à des fichiers qui devront être copiés par Ansible du présent dépôt vers la machine cible.

Ces fichiers devront être
* enregistrés dans le sous-dossier [../dataroot_files/](../dataroot_files/) (relativement à la localisation de ce readme) ;
* nommés comme décrit dans l'attribut `filename` ;
* placés dans un sous-dossier (à créer manuellement s'il n'existe pas déjà) possédant le même chemin que celui décrit dans l'attribut `filepath` (relativement au sous-dossier `dataroot_files/` déjà évoqué). Si `filepath` = `/`, par exemple, alors le fichier devra être placé à la racine du sous-dossier `dataroot_files/`.

Notes :
* si le contenu du fichier a un contenu variable, une extension `.j2` doit être ajoutée à son `filename`, pour qu'**Ansible le traite comme un template** Jinja (voir https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html).
* Rappel : les playbooks qui exploitent cet inventaire, vont chercher dans tous les fichiers yaml ou json du dossier `group_vars/` la définition de variables qu'ils doivent utiliser pendant leur l'exécution. Si un jour un point de config Moodle possédait un fichier `.json`, `.yml` ou `.yaml` dans son attribut `files`, Ansible interpreterait le fichier associé comme tous ses autres fichiers de config (du playbook et pas de Moodle). Il pourrait s'en suivre des effets non désirés plus ou moins préjudiciables. En conséquence, **ajouter une extension `.j2` à tous les fichiers yaml ou json** déposés dans le sous-dossier `file/`. Ainsi Ansible n'y cherchera pas de définition de variables qui le concerne, mais des expressions Jinja qu'il ne trouvera probablement pas puisqu'en réalité il ne s'agirait pas de vrai template et ainsi copiera le fichier sur la machine cible, en l'état.
