#!/bin/bash
# trigger_defender_uninstall.sh
# MDE Linux Offboard Script
# Detects OS package manager (yum/apt/zypper) and schedules mdatp removal via cron

if command -v yum &> /dev/null; then
    UNINSTALL_CMD="sudo yum remove -y mdatp"
elif command -v apt &> /dev/null; then
    UNINSTALL_CMD="sudo apt-get remove -y mdatp"
elif command -v zypper &> /dev/null; then
    UNINSTALL_CMD="sudo zypper remove -y mdatp"
else
    echo "Error: No supported package manager found (yum/apt/zypper)!"
    exit 1
fi

echo "Detected uninstall command: $UNINSTALL_CMD"
(crontab -l 2>/dev/null; echo "* * * * * $UNINSTALL_CMD; crontab -l | grep -v '$UNINSTALL_CMD' | crontab -") | crontab -
echo "Cron job scheduled. mdatp will be removed within 1 minute."
