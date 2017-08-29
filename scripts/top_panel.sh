#!/usr/local/bin/bash

fgcolor="#f8f8f8"
font='Roboto Medium:size=13'


workspace() {
  let desktop=$(xprop -root -notype _NET_CURRENT_DESKTOP | awk -F' = ' '{print $2}';)+1
  echo "^fn(DroidSansMonoForPowerline Nerd Font:size=22)^fn()^p(;6) $desktop"
  return
}


users(){
  total=$(w -h | awk '{print $1}' | wc -l)
  user_icon_color=$fgcolor
  intruder=$(w -h | awk '{print $3}' | grep -v :0)
  if [ $intruder ]
  then
    user_icon_color="#cc0000"
  fi
  # echo "$total users found..."
  if [[ $total -lt 1 ]]
  then
    total=1
    header="^p(;-6)^fn(DroidSansMonoForPowerline Nerd Font:size=22) ^p(-6;6)^fn($font)No Active Sessions"
  else
          header="^p(;-6)^fg($user_icon_color)^fn(DroidSansMonoForPowerline Nerd Font:size=22) ^p(-6;6)^fn($font)$total Active Sessions^fg($fgcolor)"
  fi
  echo "$header"
  return
}


jails(){
  total=0
  header=""

  total=$(iocage list -h | grep up | awk '{print $1}' | wc -l)
  jailcmd="./commands/jail_list.sh"
  if [[ $total -lt 1 ]]
  then
	  header="^p(;-6)^fn(DroidSansMonoForPowerline Nerd Font:size=22) ^p(;6)^fn(Roboto Medium:Regular:size=13)No Jails Running"
    total=2
  elif [[ $total = 1 ]]
  then
    header="^p(;-6)^fn(DroidSansMonoForPowerline Nerd Font:size=22) ^p(;6)^fn(Roboto Medium:Regular:size=13)$total Jail Running"
    total=2
  else
    header="^p(;-6)^fn(DroidSansMonoForPowerline Nerd Font:size=22) ^p(;6)^fn(Roboto Medium:Regular:size=13)$total Jails Running"
  fi
  echo "^ca(1,$jailcmd )$header^ca()"
  return
}


battery() {
  charge=$(acpiconf -i 0 | grep % | awk '{print $3}' | sed 's/%//')
  chargeicon=""
  chargeiconcolor="^fg(#ffffff)"
  chargestate=$(acpiconf -i 0 | grep State: | awk '{print $2}' | sed 's/%//')
  if [[ ${chargestate} != "discharging" ]]
  then
    chargeiconcolor="^fg(#00cc00)"
  elif [[ ${chargestate} = "discharging" ]] && [[ ${charge} -lt 25 ]]
  then
    chargeiconcolor="^fg(#cc0000)"
  fi  

  if [[ ${charge} -lt 100 ]] && [[ ${charge} -gt 74 ]]
  then
    chargeicon=""
  elif [[ ${charge} -lt 75 ]] && [[ ${charge} -gt 49 ]]
  then
    chargeicon=""
  elif [[ ${charge} -lt 50 ]] && [[ ${charge} -gt 24 ]]
  then
    chargeicon=""
  elif [[ ${charge} -lt 25 ]] && [[ ${charge} -gt 0 ]]
  then
    chargeicon=""
  elif [[ ${charge} = 100 ]]
  then
    chargeicon=""
  elif [[ ${charge} = 0 ]]
  then
    chargeicon=""
  else
    chargeicon="N/A"
  fi  

  echo "$charge% ^fn(DroidSansMonoForPowerline Nerd Font:size=22)^p(;-1)$chargeiconcolor$chargeicon ^fg($fgcolor)"
  return
}

while :; do
  buf=""
  buf="${buf} ^pa(1840)$(battery)"
  buf="${buf} ^pa(1780)$(workspace)"
  buf="${buf} ^pa(1580)$(jails)"
  buf="${buf} ^pa(1340)$(users)"

  echo $buf
  sleep 0.25
done |  dzen2 -h 28 -w 1920 -fn 'Roboto Medium:size=13' -ta l -xs 3 -e "button7=exit"
