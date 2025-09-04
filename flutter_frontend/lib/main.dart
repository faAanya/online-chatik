import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/auth_page.dart';
import 'package:flutter_frontend/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'package:signalr_netcore/hub_connection_builder.dart';

void main() async {
  // The location of the SignalR Server.
  //   final serverUrl = "http://10.0.2.2:3000/authentication";
  //   // Creates the connection by using the HubConnectionBuilder.
  //   final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  //   await hubConnection.start();
  //   final result = await hubConnection.invoke("Hello", args: []);
  //   print("Result: $result");

  var result = await http.post(
    Uri.parse('http://10.0.2.2:3000/authentication/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Guid': "1",
      "UserName": "mama",
      "Password": "1234567",
      "PhoneNumber": "+1234512362362",
    }),
  );

  print(result.body);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
