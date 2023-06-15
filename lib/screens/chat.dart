import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/main.dart';

class ChatScreen extends ConsumerStatefulWidget {
  List<String> msg=[];
  ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController chat=TextEditingController();




  @override
  Widget build(BuildContext context) {
    final websocket = ref.watch(webSocketProvider);
    final socketStream = websocket.listen();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
                child: websocket.isConnected?  StreamBuilder(
                  stream: socketStream,
                  builder: (context,snapshot){
                    if(snapshot.hasData)widget.msg.add(snapshot.data);
                    if(widget.msg.isEmpty) {
                      return Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.chat,color:Colors.black54,size: 150,),
                        Text('No msg yet :(')
                      ],
                    ),);
                    }

                    return ListView.builder(
                        itemCount: widget.msg.length,
                        itemBuilder: (BuildContext context,int index){
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                                child: Text(widget.msg[index])),);
                        });
                  },
                ) : const Center(child: CircularProgressIndicator(),)
              )
            ,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex:10,
                  child: TextField(
                    controller: chat,
                  ),
                ),
                Expanded(flex:2,child: IconButton(onPressed: (){
                    websocket.add(chat.text);
                    chat.clear();
                }, icon: const Icon(Icons.send_outlined)))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    final websocket = ref.watch(webSocketProvider);
    websocket.disconnect();
    chat.dispose();
    super.dispose();
  }
}
