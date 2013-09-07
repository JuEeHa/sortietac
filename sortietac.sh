#!/bin/sh

LOGFILE="$HOME/irclogs/freenode/#osdev-offtopic.log"

function join_channel() {
  echo ":j $1"
}

function pick_random_line() {(
  TMP=$(mktemp)
  grep -vi "$(cat secret)" > "$TMP"
  NUM_LINES=$(wc -l -- "$TMP" | cut -d ' ' -f 1)
  tail -n $(($RANDOM%$NUM_LINES)) -- "$TMP" | head -n 1
  rm -f -- "$TMP"
)}

function say_something_sortiecat_would_say()
{
  grep '^..:.. <.sortiecat>' -- "$LOGFILE" | \
  pick_random_line |  
  cut -d '>' -f 2- | \
  cut -d ' ' -f 2-
}

join_channel '#osdev-offtopic'

TALK=yes
COUNT=0

while true
do
	test -n "$TALK" && say_something_sortiecat_would_say
	sleep $(($RANDOM%(10*60)))
	if test $COUNT -lt 30
	then
		COUNT=$(($COUNT+1))
	else
		if test -n "$TALK"
		then
			TALK=
		else
			TALK=yes
		fi
		COUNT=0
	fi
done
