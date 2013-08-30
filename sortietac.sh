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

(
  (while sleep $(($RANDOM%(5*60))); do echo random_time_passed; done) &
) | while read EVENT; do
  case "$EVENT" in
    random_time_passed) say_something_sortiecat_would_say ;;
  esac
done