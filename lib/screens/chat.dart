import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController chat=TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080/ws'),
  );
  List<String> msg=[];
  String lastmsg ='';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData)msg.add(snapshot.data);
              return Expanded(
                child: ListView.builder(
                  itemCount: msg.length,
                    itemBuilder: (BuildContext context,int index){
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                        child: Text(msg[index])),);
                }),
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex:10,
                  child: TextField(
                    controller: chat,
                  ),
                ),
                Expanded(flex:2,child: IconButton(onPressed: (){
                    lastmsg='';
                    channel.sink.add(chat.text);
                    chat.clear();
                }, icon: Icon(Icons.send_outlined)))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    chat.dispose();
    super.dispose();
  }
}
