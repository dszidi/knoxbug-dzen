#!/usr/local/bin/bash

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

  echo $buf
  sleep 1
done |  dzen2 -h 28 -w 1920 -fn 'Roboto Medium:size=13' -ta l -xs 3 -e "button7=exit"
