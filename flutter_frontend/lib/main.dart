import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/auth_page.dart';
import 'package:signalr_netcore/signalr_client.dart';

void main() async {
  // The location of the SignalR Server.
  final serverUrl = "http://localhost:5037/chat";
  // Creates the connection by using the HubConnectionBuilder.
  final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  await hubConnection.start();
  try {
    final result = await hubConnection.invoke("Send", args: ["Mama"]);
  } catch (e) {
    print(e);
  }
  // When the connection is closed, print out a message to the console.
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthPage());
  }
}
