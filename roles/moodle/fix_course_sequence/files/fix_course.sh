#!/bin/bash

if [ $# -lt 2 ]; then
	cat << EOF
	
Script qui automatise 
1- le lancement de la vérification d'intégrité, voire sa réparation, 
à distance, au travers d'une connexion SSH ;
2- l'ajout d'une trace dans le fichier de log en cas de réparation ;
3- l'envoi d'un mail aux collègues pour informer de la réparation manuelle

Prérequis :
- travailler sous Linux

Usage : 
bash fix_course.sh (ecp|foad) course [fix]
EOF
	exit
fi

#echo $1, $2, $3

if [ $1 = 'ecp' ]; then
	P=/path/to/ecampus/moodle
	H=user@ecampus-backup.example.com
else
	P=/path/to/foad/moodle
	H=user@foad-backup.example.com
fi

CDE="ssh -t $H sudo -u web_user /usr/bin/php $P/admin/cli/fix_course_sequence.php -c=$2"

if [ $# -eq 3 ] && [ $3 = 'fix' ]; then
	$CDE' --fix'
	if [ $? -eq 0 ]; then
		echo "Correction OK"
		ssh -t $H sudo -u web_user sed -i -e '\$aCorrection\ manuelle\ '"$2" /path/to/log/fix_course_sequence_errors.log
		telnet smtp.example.com 25 << EOF
HELO example.com
MAIL FROM: service.technique@example.com
RCPT TO: admin@example.com
DATA
MIME-Version: 1.0
Content-Type: text/html
Subject: Correction manuelle rupture d'intégrité

<html><body>
<p>Rupture d'intégrité corrigée manuellement pour cours <strong>$2</strong> sur <strong>$( hostname )</strong></p>

<p>Pour plus de détails, voir <a href="https://webcemu.unicaen.fr/dokuwiki/doku.php?id=cemu:plateformes:moodle:documentation:debug_fix_course_sequence">notre wiki</a>
</body></html>
.
quit
EOF
	fi
	
else
	$CDE
fi

