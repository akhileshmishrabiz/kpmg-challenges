import requests
import json

url="https://bundelkhand.xyz"
r= requests.get(url)
print(r.text.splitlines())
print(json.loads(r.text))


if 