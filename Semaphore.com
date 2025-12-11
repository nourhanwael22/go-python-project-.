import threading 
import time 

recp=threading.Semaphore(1)

def enter_exroom(n):
    global recp
    print(f"pat {n} is waiting")
    recp.acquire() 
    print(f"pat {n} is in the exam room")
    time.sleep(2)
    print(f"pat {n} out of the exam room")
    recp.release()
    
pats = []
for i in range (10):
     pat=threading.Thread(target=enter_exroom,args=(i,))
     pats.append(pat)
     pat.start()
 
for pat in pats:
     pat.join()
