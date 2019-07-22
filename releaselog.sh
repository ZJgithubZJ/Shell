#!/bin/bash
/bin/find /app/dmz/hallserver/log/ -type f -name '*.log*' -mtime +0 -exec rm -rf {} \;
/bin/find /app/dmz/activityserver4/activityserver/log/ -type f -name '*.log*' -mtime +1 -exec rm -rf {} \;
/bin/find /app/dmz/activityserver4/activityserver/log/ -type f -name '*.sql' -mtime +1 -exec rm -rf {} \;
/bin/find /app/dmz/securityserver/log/ -type f -name '*.log*' -mtime +1 -exec rm -rf {} \;
/bin/find /app/dmz/router/router1/log/ -type f -name '*.log*' -mtime +1 -exec rm -rf {} \;
/bin/find /app/dmz/router/router2/log/ -type f -name '*.log*' -mtime +1 -exec rm -rf {} \;
/bin/find /app/dmz/itemserver/log/ -type f -name '*.log*' -mtime +1 -exec rm -rf {} \;
/bin/find /app/dmz/backserver/log/ -type f -name '*.log*' -mtime +1 -exec rm -rf {} \;
