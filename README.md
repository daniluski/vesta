[Vesta Control Panel Fork (CentOS 8 & 9)](http://vestacp.com/)
==================================================

[![Build Status](https://travis-ci.org/madeITBelgium/vesta.svg?branch=master)](https://travis-ci.org/madeITBelgium/vesta)
[![GitHub version](https://badge.fury.io/gh/madeITBelgium%2Fvesta.svg)](https://badge.fury.io/gh/madeITBelgium%2Fvesta)
[![codecov](https://codecov.io/gh/madeITBelgium/vesta/branch/master/graph/badge.svg)](https://codecov.io/gh/madeITBelgium/vesta)

* Vesta is an open source hosting control panel.
* Vesta has a clean and focused interface without the clutter.
* Vesta has the latest of very innovative technologies.

How to install (2 step)
----------------------------
Connect to your server as root via SSH
```bash
ssh root@your.server
```

Download the installation script, and run it:
```bash
curl https://cp.madeit.be/vst-install.sh | bash
```

How to install (3 step)
----------------------------
If the above example does not work, try this 3 step method:
Connect to your server as root via SSH
```bash
ssh root@your.server
```

Download the installation script:
```bash
curl -O https://cp.madeit.be/vst-install.sh
```
Then run it:
```bash
bash vst-install.sh
```

License
----------------------------
Vesta is licensed under  [GPL v3 ](https://github.com/madeITBelgium/vesta/blob/master/LICENSE) license

CentOS 8 Support
----------------------------
before using this repo on centOS 8 please read #75

Extra features
----------------------------
- IPv6 Support
- Plugin support
- Letsencrypt on maildomains
- Letsencrypt on vesta CP
- DNSSEC
- Exim Mail Rate limit


## Upgrade Mysql to 11.5
Since version 0.0.19 we added a script to upgrade your MySQL Server to MariaDB Version 11.5

```
bash /usr/local/vesta/upd/upgrade_mysql.sh
```

## Upgrade PHP to 8.3
Since version 0.0.21 we added a script to upgrade your PHP version to PHP 8.3

```
bash /usr/local/vesta/upd/upgrade_php.sh
```


## Migrate from Vesta CP to Vesta CP by Made I.T. (this fork)
We created a script that automaticly replace the original Vesta CP to the latest version of this fork. This is currently in BETA!

Connect to your server as root via SSH
```bash
ssh root@your.server
```

Download the installation script:
```bash
curl -O https://raw.githubusercontent.com/madeITBelgium/vesta/master/install/vst-install-rhel-migrate.sh
```
Then run it:
```bash
bash vst-install-rhel-migrate.sh
```
