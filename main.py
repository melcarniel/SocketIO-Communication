import RPi.GPIO as GPIO
import time
import socketio

GPIO.setmode(GPIO.BCM)

# init pin for led
GREEN_LED = 25
GPIO.setup(GREEN_LED, GPIO.OUT)

# Connect Raspberry to NodeJS SocketIO
sio = socketio.Client()
sio.connect('http://192.168.1.132:3000')

pwm = GPIO.PWM(GREEN_LED, 100)    # Created a PWM object
pwm.start(0)                      # Started PWM at 0% duty cycle


@sio.on('connect')
def connect(sid, environ):
    print('connect ', sid)


@sio.on('disconnect')
def disconnect(sid):
    print('disconnect ', sid)


@sio.on('ledOn')
def led(sid):
    print('turning on led')
    pwm.start(0)
    for x in range(100):
        pwm.ChangeDutyCycle(x)  # Change duty cycle
        time.sleep(0.01)


@sio.on('ledOff')
def led(sid):
    print('turning off led')
    for x in range(100, 0, -1):
        pwm.ChangeDutyCycle(x)
        time.sleep(0.01)
    pwm.stop()
