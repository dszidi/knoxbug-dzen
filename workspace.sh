#!/usr/local/bin/bash

font='Roboto Medium:size=13'

workspace() {
  let desktop=$(xprop -root -notype _NET_CURRENT_DESKTOP | awk -F' = ' '{print $2}';)+1
  echo "^fn(DroidSansMonoForPowerline Nerd Font:size=22)^fn($font) $desktop"
  return
}

while :; do
  buf=""
  buf="${buf}^pa(1620) $(workspace)"

  echo $buf
  sleep 0.25
done |  dzen2 -h 28 -w 1920 -fn 'Roboto Medium:size=13' -ta l -xs 3 -e "button7=exit"
