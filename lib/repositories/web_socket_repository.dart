import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketRepository{

  WebSocketChannel connect(){
    final channel =  WebSocketChannel.connect(
      Uri.parse('ws://localhost:8080/ws'),
    );
    return channel;
  }

  void dispose(WebSocketChannel channel){
    channel.sink.close();
  }
}