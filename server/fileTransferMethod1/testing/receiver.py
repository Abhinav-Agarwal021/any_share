import os
import socket
import sys

host = "127.0.0.1"
port = 10001
filename = "dummy.txt"
f = open("dummy.txt","w")
try:
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
except socket.gaierror:
    print(socket.gaierror)
    sys.exit()

s.connect((host,port))
data = s.recv(4037).decode()
f.write(data)
f.close()
