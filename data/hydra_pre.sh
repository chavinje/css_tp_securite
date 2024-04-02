# Ne pas se fier a cette version, récupérer le PHPSESSID à partir d'un navigateur Web
# get user token
TOKEN=$(curl -c dvwa.session -s http://192.168.56.71:80/dvwa/vulnerabilities/brute/ | grep 'user_token' | awk -F 'value=' '{print $2}' | cut -d"'" -f2)

# get session id
PHPSESSID=$(grep PHPSESSID dvwa.session | awk -F' ' '{print $7}')

# log in
curl -L -b "PHPSESSID=${PHPSESSID};security=low" -v -d "username=admin&password=password&Login=Login&user_token=${TOKEN}" http://192.168.56.71/dvwa/login.php

