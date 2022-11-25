import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client

    //Si no funciona la URL, intentar con mi IP:3000
    IO.Socket socket = IO.io('http://localhost:3000');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
      _serverStatus = ServerStatus.online;
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) {
      print('disconnect');
      _serverStatus = ServerStatus.offline;

      });
    socket.on('fromServer', (_) => print(_));
  }
}
