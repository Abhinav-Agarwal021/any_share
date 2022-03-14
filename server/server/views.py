from django.shortcuts import HttpResponse, render
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
import environ
import base64
import json
env = environ.Env()
environ.Env.read_env()


def generateKey(user1, user2):
    data = {user1: user1, user2: user2}
    data = json.dumps(data).encode()
    key = str(env('encryption_key')).encode()
    cipher = AES.new(key, AES.MODE_CTR)
    ct_bytes = cipher.encrypt(data)
    nonce = base64.b64encode(cipher.nonce).decode("utf-8")
    ct = base64.b64encode(ct_bytes).decode('utf-8')
    result = json.dumps({'nonce': nonce, 'ciphertext': ct})
    print(result)



def handleFileTransfer(request):
    pass


def index(request, key):
    generateKey("shady", "shadie")
    return render(request, "chats.html")

