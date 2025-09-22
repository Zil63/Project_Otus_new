#!/bin/bash
# Setup automatic health checks

CRON_JOB="*/5 * * * * /home/vagrant/project/scripts/health-check.sh >> /var/log/auto-recovery.log 2>&1"

# Add to crontab
(crontab -l 2>/dev/null | grep -v "health-check.sh"; echo "$CRON_JOB") | crontab -

echo "Automatic recovery cron job installed"