#!/usr/bin/env python3
# set ENV:
# CFKEY=API-key
# CFUSER=username(email)
# CFZONE=zone-name
# CFDNIP=x.x.x.x
# CFHOST=host1-you-want-to-change,host2-you-want-to-change
# CFTYPE=A,CNAME # effect rec type

from cloudflare import CloudFlare
import os

cfkey =  os.getenv("CFKEY", "")
cfuser = os.getenv("CFUSER", "")
cfzone = os.getenv("CFZONE", "")
cfdnip = os.getenv("CFDNIP", "")
cfhost = os.getenv("CFHOST", "").split(",")
cftype = os.getenv("CFTYPE", "A,CNAME").split(",")

def filter_rec(rec):
	return rec["name"] in cfhost and rec["type"] in cftype

cfapi = CloudFlare(cfuser, cfkey)
recobjs = cfapi.rec_load_all(cfzone)["response"]["recs"]["objs"]
recs = list(filter(filter_rec, recobjs))
for rec in recs:
	res = cfapi.rec_edit(
		z=cfzone,
		_type=rec["type"],
		_id=rec["rec_id"],
		name=rec["name"],
		content=cfdnip,
		service_mode=rec["service_mode"],
		ttl=rec["ttl"])
	if res["msg"] == None:
		print(rec["name"], "update", cfdnip, res["result"])
	else:
		print(rec["name"], "update", cfdnip, res["result"], res["msg"])

