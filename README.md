# PCH gists

## About

Gists from [PCH](http://pch.net) - since github doesn't support actual gists for an org :(

## Gists


* [IMPACT.wget.recursive.sh](https://github.com/Packet-Clearing-House/gists/blob/master/IMPACT.wget.recursive.sh) - wget bash script to download [IMPACT](https://www.impactcybertrust.org/)  (formerly PREDICT) datasets hosted at PCH
* [nonce.php](https://github.com/Packet-Clearing-House/gists/blob/master/nonce.php) - a snippet of how we do nonces for [anti-CSRF](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_%28CSRF%29) on pch.net
* [random.htpassphrase.sh](https://github.com/Packet-Clearing-House/gists/blob/master/random.htpassphrase.sh) - bash script to generate pass phrases
* [random.htpasswds.sh](https://github.com/Packet-Clearing-House/gists/blob/master/random.htpasswds.sh) - bash script to populate an .htpassword file 
    with usernames and rand passwords
* [dns.stats.wget.csv.sh](https://github.com/Packet-Clearing-House/gists/blob/master/dns.stats.wget.csv.sh) - wget based bash script to download DNS query stats
* [dns.stats.curl.csv.sh](https://github.com/Packet-Clearing-House/gists/blob/master/dns.stats.curl.csv.sh) - curl based bash script to download DNS query stats
* [maptable.percentile.helper.js](https://github.com/Packet-Clearing-House/gists/blob/master/maptable.percentile.helper.js) - JavaScript helper methods if you want to generate ranks for your [maptable](https://github.com/Packet-Clearing-House/maptable/tree/dev-34) values which you can then use to generate percentile color transforms.  Used on all pch.net maps (eg [IXP Dir](https://www.pch.net/ixp/dir)). Requires [jQuery](https://jquery.com/).
* [sha512.php](https://github.com/Packet-Clearing-House/gists/blob/master/sha512.php) - Simple PHP script to take clear text password and generate SHA512 hash.  Uses ``openssl_random_pseudo_bytes()`` to generate 10 char salt and uses 5000 rounds of hashing - both via ``crypt()``. This does have two lines endemic PCH css and logo - but they only output if the files are present via ``is_file()``
* [apachetop.load.ps.sh](https://github.com/Packet-Clearing-House/gists/blob/master/apachetop.load.ps.sh) - While debugging our web server running Apache on Centos 6.8 we needed a way to easily correlate high load average with web traffic.  This bash script which logs load average, top process by count and top IP/Count/Directory from the apache access_log solved the problem nicely!
* [dump.sql.gpg.sh](https://github.com/Packet-Clearing-House/gists/blob/master/dump.sql.gpg.sh) - Working through our process to be [GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation) compliant, we now encrypt all database dumps/backups with GPG.  This script enables developers to easily make encrypted backups with a mini-wizard on an ad-hoc basis. Be sure the run ``gpg --import KEY`` with they key you want to use in backup first.

## License

MIT
