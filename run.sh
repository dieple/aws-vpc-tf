#!/bin/bash

PROG='`basename $0`'
OPTIONS='plan' #default to plan
VARFILE='terraform2.tfvars'

usage()
{
	echo ''
	echo 'Usage: $PROG [options]'
	echo ''
	echo '[-o OPTION (e.g. apply/plan/destroy)]'
	echo ''
}

#
# Main program
#
while getopts 'o:?' 2> /dev/null ARG
do
	case $ARG in
		o)	OPTIONS=$OPTARG;;

		?)	usage
			exit 1;;
	esac
done

if [ -z '$OPTIONS' ]
then
	echo 'Options required'
	usage
	exit 1
fi

if [ '$OPTIONS' = 'all' ] || [ '$OPTIONS' = 'apply' ]; then
	terraform plan -var-file $VARFILE -out $OUTFILE
	terraform apply -var-file $VARFILE
elif [ '$OPTIONS' = 'apply' ]; then
	terraform apply -var-file $VARFILE
elif [ '$OPTIONS' = 'destroy' ]; then
	terraform plan -destroy -var-file $VARFILE -out $OUTFILE
	terraform apply $OUTFILE
fi
