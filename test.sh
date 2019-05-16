curl -X POST localhost:5000/login --data '{ "username": "gabe", "password": "temp" }' -H 'content-type: application/json'
curl -X POST localhost:5000/login --data '{ "username": "alan", "password": "temp" }' -H 'content-type: application/json'
curl localhost:5000/actions?key=alan
curl localhost:5000/actions?key=gabe
curl -X POST localhost:5000/logout --data '{ "key": "alan" }' -H 'content-type: application/json'
curl -X POST localhost:5000/logout --data '{ "key": "gabe" }' -H 'content-type: application/json'
