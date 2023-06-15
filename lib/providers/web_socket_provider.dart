import 'dart:async';

import 'package:chat_app/repositories/web_socket_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider extends ChangeNotifier{
  late WebSocketChannel _channel;
  bool isConnected = false;

  void connect(){
    _channel = WebSocketRepository().connect();
    isConnected = true;
    notifyListeners();
  }

  Stream<dynamic> listen(){
    return _channel.stream;
  }

  void add(String msg){
    _channel.sink.add(msg);
    notifyListeners();
  }

  void disconnect(){
    WebSocketRepository().dispose(_channel);
  }



}