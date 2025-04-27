#!/bin/bash
# Purpose: Real-time CPU Utilization Monitoring Shell Script

HOSTNAME=$(hostname)
WARNING=90
CRIT=98
LOG_DIR="/var/log/cpuhistory"
LOGFILE="$LOG_DIR/hist-$(date +%h%d%y).log"
MAILER="/bin/mail"
CRITmailto="YOUREMAIL@DOMAIN.COM"
mailto="YOUREMAIL@DOMAIN.COM"

mkdir -p $LOG_DIR
touch $LOGFILE

CPU_LOAD=$(top -b -n2 -d1 | grep "Cpu(s)" | tail -n1 | \
awk -F'id,' -v prefix="$prefix" '{split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); print 100 - v}' | awk -F. '{print $1}')

if [ "$CPU_LOAD" -ge "$CRIT" ]; then
    echo "$(date '+%F %H:%M:%S') CRITICAL - $CPU_LOAD% on $HOSTNAME" >> $LOGFILE
    echo "CPU Load is Critical: $CPU_LOAD% on $HOSTNAME" | $MAILER -s "CPU Critical Alert: $CPU_LOAD% on $HOSTNAME" $CRITmailto
    exit 2
elif [ "$CPU_LOAD" -ge "$WARNING" ]; then
    echo "$(date '+%F %H:%M:%S') WARNING - $CPU_LOAD% on $HOSTNAME" >> $LOGFILE
    echo "CPU Load is Warning: $CPU_LOAD% on $HOSTNAME" | $MAILER -s "CPU Warning Alert: $CPU_LOAD% on $HOSTNAME" $mailto
    exit 1
else
    echo "$(date '+%F %H:%M:%S') OK - $CPU_LOAD% on $HOSTNAME" >> $LOGFILE
    exit 0
fi