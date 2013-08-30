#!/bin/sh

echo ':j #osdev-offtopic'
while true
do
	MAXLEN=$(grep -c '^..:.. <.sortiecat>' ~/irclogs/freenode/#osdev-offtopic.log)
	grep '^..:.. <.sortiecat>' ~/irclogs/freenode/#osdev-offtopic.log | tail -n $(($RANDOM%$MAXLEN)) | head -n 1 | cut -d '>' -f 2- | cut -d ' ' -f 2-
	sleep $(($RANDOM%(5*60)))
done
