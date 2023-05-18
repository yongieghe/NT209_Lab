s = "269682250"
v7 = "`Et--"
v4 = "9650`Et--"

username = s
key = v4
password=""
for i in range(9):
    password+=chr((ord(username[i])+ord(key[i]))//2)

print(password)


