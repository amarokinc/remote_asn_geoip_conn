# Add Remote ASN and GeoIP Info Directly to Conn Log
This zeek script will add the Autonomous System Number (ASN) and Geolocation information (country code, region, city, lat/long) for the **remote** IP address directly to conn.log. The script will perform a simple check against against the orig and resp hosts to determine which one is not defined as part of your local subnet(s) then perform the lookups accordingly.

## Notes:
  * In order for you to use GeoLocation data with Zeek, you will need to install libaxminddb and build from source. Zeek has documented that process [here](https://docs.zeek.org/en/current/frameworks/geoip.html)
  * You will need two databases from MaxMind: GeoLite2 ASN and GeoLite2 City. You can sign up and access them for free [here](https://dev.maxmind.com/geoip/geoip2/geolite2/)
  * In order to update these databases monthly, follow MaxMind's [guide](https://dev.maxmind.com/geoip/geoipupdate/)
  * The script leverages Zeek's [default locations](https://docs.zeek.org/en/current/frameworks/geoip.html) for the MaxMind databases - highly recommend using those or you will need to customize your configs
  * Your local subnets are defined in networks.cfg and configured when using zeekctl-deploy. If not using zeekctl, you may configure using zeek's [example](https://docs.zeek.org/en/current/quickstart/index.html?highlight=Site%3A%3Alocal_nets#local-site-customization)
  * This has been used mostly on small, internet-facing honeypots and we have not experienced and performance issues. However, we have not tested in an enterprise environment with high a volume of traffic - use with caution in such environments as this will perform numerous lookups and could impact performance
  * Thank you to [brimsec](https://github.com/brimsec) for their example on adding geoIP information directly to conn.log. If you're looking to add only GeoIP information (no ASN) for **both** the orig and resp hosts, check out their [zeek package](https://github.com/brimsec/geoip-conn)
