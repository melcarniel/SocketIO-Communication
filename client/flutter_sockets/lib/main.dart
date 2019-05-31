import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';

void main() => runApp(MyApp());

// URL of SOCKET.IO Server
const String URI = "http://192.168.1.132:3000/";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  SocketIOManager manager;
  SocketIO socket;
  bool isProbablyConnected = false;
  bool ledState = false;

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    initSocket();
  }

  /**
   * try to connect to socket.io server
   */
  initSocket() async {
    setState(() => isProbablyConnected = true);
    socket = await manager.createInstance(URI, enableLogging: false);
    socket.onConnect((data) {
      print("connected...");
      print(data);
      sendMessage();
    });
    socket.onConnectError(print);
    socket.onConnectTimeout(print);
    socket.onError(print);
    socket.onDisconnect(print);
    socket.connect();
  }

  /**
   * close the connection of the socket
   */
  disconnect() async {
    await manager.clearInstance(socket);
    setState(() => isProbablyConnected = false);
  }

  /**
   * emit message to socket.io server
   */
  sendMessage() {
    if (socket != null) {
      print("sending message...");
      socket.emit(ledState == true ? "ledOff" : "ledOn", ['FLUTTER SAYS HEI']);
      print("Message emitted...");
      setState(() {
        ledState = !ledState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Socket.IO example'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: sendMessage,
                      child:
                          ledState == true ? Text('LED Off') : Text('LED On'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
