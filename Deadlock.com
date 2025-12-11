
import threading
import time

resource_1 = threading.Lock()
resource_2 = threading.Lock()

def thread_1():
    with resource_1:
        print("Thread a acquired resource 1")
        time.sleep(1)
        print ("Thread a waiting for resource 2")
    with resource_2:
        print ("Thread a acquired resource 2")


def thread_2():
    with resource_2:
        print("Thread b acquired resource 2")
        time.sleep(1)
        print ("Thread b waiting for resource 1")
        with resource_1:
            print ("Thread b acquired resource 1")

a=threading.Thread(target=thread_1)
b=threading.Thread(target=thread_2)
a.start()
b.start()
a.join()
b.join()
