# Omnios build script for DalmatinerFE

Published to http://repository.stratobuilder.com

CI: https://builderl.stratobuilder.com/builds/philipcristiano/omniosce-build-dalmatinerfe


```
pkg set-publisher http://repository.stratobuilder.com repository.stratobuilder.com
pkg install dalmatinerfe
# Configure in /data/dalmatinerfe/etc/dfe.conf
svcadm enable svc:/application/dalmatinerfe
```
