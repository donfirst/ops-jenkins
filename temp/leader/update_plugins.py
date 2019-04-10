#!/usr/bin/env python

import requests
import json
import os

filePath = os.path.join(os.path.dirname(os.path.realpath(__file__)), "plugins.txt")

r = requests.get('http://updates.jenkins-ci.org/update-center.json')

if r.status_code != 200:
    print "Download failed"
    exit()

jsonp = r.text
data_json = jsonp[len('updateCenter.post('):-2]

data = json.loads(data_json)

# Read plugins file and split
new_plugins = {}
for line in open(filePath, 'r'):
    name, version = line.rstrip().split(':')
    if data['plugins'][name]['version'] != version:
        new_plugins[name] = data['plugins'][name]['version']
    else:
        new_plugins[name] = version


with open(filePath, 'w') as the_file:
    for key in sorted(new_plugins):
        the_file.write(key + ":" + new_plugins[key] + "\n")
