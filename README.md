# SocketIO Communcation

Example for realtime application communication with Socket.IO (Flutter + NodeJS + Python)

## Prerequisites
- [Git](https://git-scm.com/)
- [Node.js and npm](nodejs.org) Node >= 4.x.x, npm >= 2.x.x
- [Flutter](https://flutter.dev/)
- [Python](https://www.python.org/downloads/)
- [Socket.IO for Python](https://python-socketio.readthedocs.io/en/latest/client.html)

## Setup
- Start the [NodeJS](https://nodejs.org/en/) http server with Socket.IO 
    - `cd server`
    - `npm run start`
- Start the Python instance on a raspberry pi
    - Run `python main.py` on your raspberry but make shure to configure the GPIO pin right
- [Build the mobile application and test it](https://flutter.dev/docs)
    - Run `flutter build ios/android`