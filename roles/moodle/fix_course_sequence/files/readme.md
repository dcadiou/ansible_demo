2 scripts autour de la détection / correction des ruptures d'intégrité (voir https://webcemu.unicaen.fr/dokuwiki/doku.php?id=cemu:plateformes:moodle:administration:invalid_courseid)

* `check_fix_course_sequence.sh` -> script installé sur le serveur et lancé à intervalle régulier par cron pour détecter/informer d'éventuels soucis
* `fix_course.sh` -> script à exécuter à distance depuis son poste local pour intervenir sur le problème
