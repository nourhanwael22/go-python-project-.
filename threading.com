
import threading 
import time 

def print1():
    print("starting of threading:",threading.current_thread().name)
    time.sleep(2)
    print("end of threading:",threading.current_thread().name)
    
    

def print2():
    print("starting of threading:",threading.current_thread().name)
    print("end of threading:",threading.current_thread().name)


a= threading.Thread(target=print1,name="thread1")
b= threading.Thread(target =print2,name="thread2")


a.start()
b.start()
