g = open("a.txt","r")
f = g.read()
l = []
a = ''
for c in f:
    if c=='\n':
        l.append(a)
        a = ''
    else:
        a+=c
h = open("a.txt","w")
h.write(str(l))