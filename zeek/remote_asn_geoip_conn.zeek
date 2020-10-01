module RemoteAsnGeoConn;

export {
	type geo_loc: record {
		country_code: string &optional &log;
		region: string &optional &log;
		city: string &optional &log;
		latitude: double &optional &log;
		longitude: double &optional &log;
	};

	redef record Conn::Info += {
		remote_asn: count &optional &log;
		remote_geo: geo_loc &optional &log;
		};

	}

event connection_state_remove(c: connection)
   {
	local remote_geo: geo_loc;
	local remote_loc: geo_loc;
	local remote_ip: addr;
	
	if ( Site::is_local_addr(c$id$orig_h) )
		remote_ip = c$id$resp_h;
	else
		remote_ip = c$id$orig_h;
	
	c$conn$remote_asn = lookup_asn(remote_ip);
	remote_loc = lookup_location(remote_ip);

	if ( remote_loc?$country_code )
                remote_geo$country_code = remote_loc$country_code;
        if ( remote_loc?$region )
               	remote_geo$region = remote_loc$region;
        if ( remote_loc?$city )
               	remote_geo$city = remote_loc$city;
        if ( remote_loc?$latitude )
               	remote_geo$latitude = remote_loc$latitude;
        if ( remote_loc?$longitude )
               	remote_geo$longitude = remote_loc$longitude;

	c$conn$remote_geo = remote_geo;	
	}
