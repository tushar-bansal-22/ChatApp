import 'package:chat_app/providers/web_socket_provider.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( const MyApp());
}

final webSocketProvider = ChangeNotifierProvider<WebSocketProvider>((ref) => WebSocketProvider() ..connect()) ;
class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChatScreen(),
      ),
    );
  }
}

