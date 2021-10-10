#!/usr/bin/python3

import RPi.GPIO as GPIO
import time
import sys

led = 3
#switch = 31

GPIO.setmode(GPIO.BOARD)
GPIO.setup(led, GPIO.OUT)
#GPIO.setup(switch, GPIO.IN)

command = str(sys.argv[1])
command = command[1:]
command = command[:-1]  #string ohne hochkommas

if len(sys.argv) == 1:
    print("no command recived")
    sys.exit()

print ("Number of arguments:", len(sys.argv), "arguments.")
print ('Argument List:', str(sys.argv))

if command == "licht an":
    GPIO.output(led, GPIO.HIGH)
    print("licht an")

if command == "licht aus":
    GPIO.output(led, GPIO.LOW)
    print("licht aus")

if command == "rennen":
    for i in range(100):
        GPIO.output(led, GPIO.HIGH)
        time.sleep(0.1)
        GPIO.output(led, GPIO.LOW)
        time.sleep(0.1)
        print("blink")

#GPIO.cleanup()