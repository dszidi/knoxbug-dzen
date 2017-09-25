#!/usr/local/bin/bash

fgcolor="#f8f8f8"

users(){
  total=$(w -h | awk '{print $1}' | wc -l)
  user_icon_color=$fgcolor
  intruder=$(w -h | awk '{print $3}' | grep -v :0)
  if [ $intruder ]
  then
    user_icon_color="#cc0000"
  fi

  if [[ $total -lt 1 ]]
  then
    total=1
    header="^p(10)^fn(DroidSansMonoForPowerline Nerd Font:size=33) ^fn(Roboto Medium:Regular:size=13)No Active Sessions:"
  else
          header="^p(10)^fg($user_icon_color)^fn(DroidSansMonoForPowerline Nerd Font:size=33) ^fn(Roboto Medium:Regular:size=13)$total Active Sessions:^fg($fgcolor)"
  fi
  echo "$header"
  return
}

while :; do
  buf=""
  buf="${buf}$(users)"

  echo $buf
  sleep 1
done |  dzen2 -h 28 -w 1920 -fn 'Roboto Medium:size=13' -ta l -e "button7=exit"
