#!/bin/bash
#This bash script will be used to auto update the network device information and display the result in an html document.

#Do only if in the same local area network with the linux server (please exchange ssh keys rather than using password if possible)
#ssh nabilfadjar@192.168.70.80 

#Change directory to location of temp data storage
cd /home/nabilfadjar/Documents/

while true; do
  #SSH to Fuel Server and send data of network devices to the linux server (saved as devInfoRec.txt)
  ssh root@10.20.0.2 "cat /proc/net/dev" > /home/nabilfadjar/Documents/devInfoRec.txt
  
  #Access the text file in the linux server and begin parsing the file, passing to a program to allow output of an html document
  sed 's/-|/ /g' devInfoRec.txt | sed 's/|/ /g' | sed 's/:/ /g' | awk 'BEGIN { print "<!DOCTYPE html><html><head><meta http-equiv=\"refresh\" content=\"1\"><title>Fuel Server Network Devices</title></head><body><table border=\"1\">" } { print "<tr><td>", $1, "</td>", "<td>", $2, "</td>", "<td>", $3, "</td>", "<td>", $10, "</td>", "<td>", $11, "</td></tr>" } END { print "</table></BODY></HTML>" }' > dev.html
  
  #Wait for 1 second to repeat process
  sleep 1
done

#Note: 
# -Information will be sent every 1 second.
# -The script must be halted manually (ctrl-c)
