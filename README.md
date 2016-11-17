# PCH gists
Gists from [PCH](http://pch.net) - since github doesn't support actual gists for an org :(

Current gists are:

* IMPACT.wget.recursive.sh - wget bash script to download [IMPACT](https://www.impactcybertrust.org/)  (formerly PREDICT) datasets hosted at PCH
* nonce.php - a snippet of how we do nonces for [anti-CSRF](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_%28CSRF%29) on pch.net
* random.htpassphrase.sh - bash script to generate pass phrases
* random.htpasswds.sh - bash script to populate an .htpassword file 
    with usernames and rand passwords
* dns.stats.csv.sh - wget bash script to download DNS query stats
* maptable.percentile.helper.js - JavaScript helper methods if you want to generate ranks for your [maptable](https://github.com/Packet-Clearing-House/maptable/tree/dev-34) values which you can then use to generate percentile color transforms.  Used on all pch.net maps (eg [IXP Dir](https://www.pch.net/ixp/dir)). Requires jQuery.