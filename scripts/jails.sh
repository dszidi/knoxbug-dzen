#!/usr/local/bin/bash

fgcolor="#f8f8f8"

jails(){
  total=0
  header=""
  total=$(iocage list -h | grep up | awk '{print $1}' | wc -l)
  jailcmd="./commands/jail_list.sh"

  if [[ $total -lt 1 ]]
  then
    header="^p(10)^fn(DroidSansMonoForPowerline Nerd Font:size=33) ^fn(Roboto Medium:Regular:size=13)No Jails Running:"
    total=2
  elif [[ $total = 1 ]]
  then
    header="^p(10)^fn(DroidSansMonoForPowerline Nerd Font:size=33) ^fn(Roboto Medium:Regular:size=13)$total Jail Running:"
    total=2
  else
    header="^p(10)^fn(DroidSansMonoForPowerline Nerd Font:size=33) ^fn(Roboto Medium:Regular:size=13)$total Jails Running:"
  fi
  echo "^ca(1,$jailcmd )$header^ca()"
  return
}


while :; do
  buf=""
  buf="${buf}$(jails)"

  echo $buf
  sleep 1
done |  dzen2 -h 28 -w 1920 -fn 'Roboto Medium:size=13' -ta l -e "button7=exit"
