# Groupes de hosts obligatoires

## Rappels

* Les variables définies dans des fichiers dans le dossier `inventories/group_vars/<nom du groupe...>`
  **sont automatiquement disponibles pour toutes taches** exécutées
  sur un host de ce groupe ou qui a pour ancetre ce groupe.
* Les groupes enfants héritent des variables de tous leurs groupes parents, même quand ils sont au même niveau.
* un même groupe enfant peut ('doit' dans notre cas) appartenir à plusieurs groupes parents
* un même host peut être dans différents groupes. Ses variables seront la fusion de celles dans chaque groupe.
* Des groupes peuvent contenir
    * soit d'autres groupes plus élémentaires (enfants)
```yaml
    serveurs_bd: # groupe parent
      children:
        web_ecampus: # groupe enfant
```
    * soit des hosts individuels
```yaml
    serveurs_de_cron: # groupe de hosts
      hosts:
        kecp0: # host
```

## Imbrication des groupes

Les fichiers d'inventaire ont été pensées avec une imbrication matricielle (à 2 dimensions) des groupes de hosts.

Ci-dessous une illustration du principe utilisé (description non exhaustive).

![imbrication_des_groupes](imbrication_des_groupes.png)

## Groupes parents

```yaml
bd_ecampus:
bd_collegium:
bd_prelude:
web_ecampus:
web_collegium:
web_prelude:
```

## Groupe ancêtres

Un groupe quasi universel qui contient tous les autres

```yaml
cemu:
```

### Type de serveurs

Ces groupes permettent d'identifier quel est le type de chacun des serveurs

```yaml
serveurs_bd: # pour les serveurs de base de données
serveurs_web: # pour les serveurs web
serveurs_de_cron: # si le serveur est dédié au lancement des crons Moodle
serveurs_infra: # pour les serveurs de virtualisation (comme kecampuslast)
```

### plateformes

Ces groupes permettent d'identifier quel est la plateforme concernée par chacun des serveurs

```yaml
ecampus:
collegium:
prelude:
```

### Applications

Les groupes plateforme sont eux-mêmes dans des groupes par application.

```yaml
moodle:
```

### Par caractéristiques

```yaml
shibbolethise: # Plateformes shibbolethisées
```

### Par contexte

Même nom et même périmètre que chacun des fichiers d'inventaire

```yaml
serveurs_prod:
serveurs_pp:
serveurs_dev:
serveurs_locaux:
```
