import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PriceTrackerScreen(),
    );
  }
}

class PriceTrackerScreen extends StatefulWidget {
  @override
  _PriceTrackerScreenState createState() => _PriceTrackerScreenState();
}

class _PriceTrackerScreenState extends State<PriceTrackerScreen> {


  late WebSocketChannel channel;
  String currentPrice = "Loading...";
  String lastUpdate = "Never";

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:8080'), // Update with your server URL
    );

    channel.stream.listen((message) {
      setState(() {
        currentPrice = message; // Assuming the message is the price
        lastUpdate = DateTime.now().toString();
      });
    }, onError: (error) {
      print("WebSocket error: $error");
    }, onDone: () {
      print("WebSocket connection closed");
    });
  }

  void disconnectWebSocket() {
    channel.sink.close(status.normalClosure);
  }

  @override
  void dispose() {
    disconnectWebSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Price Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Price: $currentPrice',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Last Updated: $lastUpdate',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: disconnectWebSocket,
              child: Text('Disconnect WebSocket'),
            ),
            ElevatedButton(
              onPressed: connectToWebSocket,
              child: Text('Reconnect WebSocket'),
            ),
          ],
        ),
      ),
    );
  }
}