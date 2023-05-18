#!/bin/bash
from pwn import *
import itertools as iter

program = process("./bomb")

#=========================== Phase 1 ===========================#

def phase1():
    payload = b'For NASA, space is still a high priority.'
    program.sendline(payload)

#=========================== Phase 2 ===========================#
def phase2():
    # v3 = []
    # payload = ''
    # for i in range(0,6):
    #     if i == 0:
    #         v3.append(1)
    #     else:
    #         v3.append(2*v3[i-1])
    # for i in v3 : 
    #     payload += str(i) + ' '
    # program.sendline(bytes(payload.encode()))
    program.sendline(b'0 1 1 2 3 5')
# v3 = [1, 2, 4, 8, 16, 32]
#=========================== Phase 3 ===========================#

def phase3():
    payload = b'0 p 341' 
    program.sendline(payload)

#=========================== Phase 4 ===========================#
def func4(a1,a2,a3):
    v4 = 0
    v4 = (a3-a2)/2 + a2
    if(v4 > a1):
        return 2 * func4(a1,a2,v4-1)
    if (v4 >= a1):
        return 0
    return 2 * func4(a1,v4+1,a3) + 1
def phase4():
    res = []
    payload = b'176 2'
    # v5 = 2
    # for v2 in range(1,14):
    #     for v3 in range(1,14):
    #         v6 = func4(v2,0,14)
    #         if(v6 != v5 or v3 != v5):
    #             continue
    #         else:
                # print(f"v2 : {v2}, v3 : {v3}")
                # res.append([v2,v3])
    # payload = bytes(str(res[0][0]).encode()) + b' ' + bytes(str(res[0][1]).encode()) + b' DrEvil'
    program.sendline(payload)

#=========================== Phase 5 ===========================#
def phase5():
    arr = [0xa,2,0xe,7,8,0xc,0xf,0xb,0,4,1,0xd,3,9,6,5]
    res = []
    payload = b'5 115'
    for v2 in range(0,100):
        v4 = 0
        v5 = 0
        init_v2 = v2
        v2 = v2 & 15
        while(v2 != 15):
            v4 += 1
            v2 = arr[v2]
            v5 += v2 
            if(v4 == 15):
                # print(f"init v2 : {init_v2}")
                # print(f"v4 : {v4}, v5 : {v5}")
                res.append([init_v2,v5])
    payload = bytes(str(res[0][0]).encode()) + b' ' + bytes(str(res[0][1]).encode())
    program.sendline(payload)

    
#=========================== Phase 6 ===========================#

def phase6_bruteforce(payload : str):
    p = process("./bomb")
    payload = bytes(payload.encode())
    p.sendlineafter(b"Have a nice day!\n",b"For NASA, space is still a high priority.")
    p.sendlineafter(b"How about the next one?\n",b"0 1 1 2 3 5")
    p.sendlineafter(b"Keep going!\n",b"0 p 341")
    p.sendlineafter(b"Halfway there!\n",b"176 2")
    p.sendlineafter(b"Try this one.\n",b"5 115")
    p.sendlineafter(b"On to the next...",payload)
    msg = p.recvall().decode()
    print(msg)
    p.close()
    if "Congratulations!" in msg:
        return True 
    else:
        return False
    
def phase6():
    check = False
    perm = iter.permutations(['1','2','3','4','5','6'])
    arr = []
    node1 = [0x362,1,0x4d0f4]
    res1 = []
    v13 = [0]*6
    # Bruteforce all the set satisfied 1st and 2nd condition
    [arr.append(list((i))) for i in perm]
    for i in range(0,len(arr)):
        for j in range(0,6):
            if(j == 5) : continue
            if(arr[i][j] == arr[i][j+1]):
                continue
            else:
                res1.append(arr[i]) 
    # [print(i) for i in res1]
    # ----------------------------------------------------------# 
    for test in res1:
        payload = ' '.join(test)
        print("*****************************")
        print(f"Payload tested : {payload}*")
        print("*****************************\n")
        if(phase6_bruteforce(payload)):
            print("========================= FOUND ====================")
            print(payload)
            print("====================================================\n")
            break
    # program.sendline(b"3 6 4 1 2 5")

#=========================== Secret Phase ===========================#

def secret_phase():
    payload = ''
    n1 = [0x24,0x8,0x32]

#=========================== Main Program ===========================#

        
phase1()
phase2()
phase3()
phase4()
phase5()
phase6()
# secret_phase()
program.interactive()