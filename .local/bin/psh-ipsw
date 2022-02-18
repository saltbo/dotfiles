#!/bin/bash

ips=("192.168.130.167" "192.168.143.242")
gate="192.168.143.254"

next_ip=${ips[0]}
current_ip=(`ipconfig getifaddr en0`)

if [ "${current_ip}" == ${next_ip} ]; then next_ip=${ips[1]}; fi

networksetup -setmanual "Wi-Fi" ${next_ip} 255.255.255.0 ${gate}
echo "${current_ip} => ${next_ip}"