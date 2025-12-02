#!/bin/bash

OUTPUT_FILE="/var/www/html/status.html"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df -h | grep '/$' | awk '{print $5}')
NETWORK_USAGE=$(ifstat -S 1 1 | tail -n 1 | awk '{print $1, $2}')

echo "<html><head><title>System Health Dashboard</title></head><body>" > $OUTPUT_FILE
echo "<h1 style='color: orange;'>System Health Dashboard</h1>" >> $OUTPUT_FILE
echo "<p style='color: red; font-weight: bold;'>CPU Usage: $CPU_USAGE%</p>" >> $OUTPUT_FILE
echo "<p style='color: green; font-weight: bold;'>Memory Usage: $MEMORY_USAGE%</p>" >> $OUTPUT_FILE
echo "<p style='color: blue; font-weight: bold;'>Disk Usage: $DISK_USAGE</p>" >> $OUTPUT_FILE
echo "<p style='color: purple; font-weight: bold;'>Network Usage: $NETWORK_USAGE</p>" >> $OUTPUT_FILE
echo "</body></html>" >> $OUTPUT_FILE

sudo chmod 775 /var/www/html/status.html
