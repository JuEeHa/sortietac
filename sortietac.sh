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

(
  (while sleep $(($RANDOM%(5*60))); do echo speak; done) &
  (while sleep $((30*60)); do echo talk_on; done) &
  (sleep $((20*30)); while sleep $((30*60)); do echo talk_off; done) &
  (while read LINE; do test -n "$(echo "$LINE" | cut -d ':' -f 2- | cut -d ' ' -f 5- | grep 'sortietac')" && echo speak; done) &
) | while read EVENT; do
  case "$EVENT" in
    speak) test -n "$TALK" && say_something_sortiecat_would_say ;;
    talk_on) TALK=yes ;;
    talk_off) TALK= ;;
    *) echo "Unhandled event: '$EVENT'" ;;
  esac
done