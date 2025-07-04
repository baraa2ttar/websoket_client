import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class PriceTrackerController extends GetxController {
  late WebSocketChannel channel;
  var currentPrice = "Loading...".obs;
  var lastUpdate = "Never".obs;
  var priceHistory = <Map<String, dynamic>>[]
      .obs; // Each entry: {'price': double, 'time': DateTime}

  @override
  void onInit() {
    super.onInit();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:8080'), // Update with your server URL
    );

    channel.stream.listen(
      (message) {
        currentPrice.value = message; // Assuming the message is the price
        lastUpdate.value = DateTime.now().toString();
        double? price = double.tryParse(message);
        if (price != null) {
          priceHistory.add({'price': price, 'time': DateTime.now()});
          if (priceHistory.length > 50) {
            priceHistory.removeAt(0); // Keep only the latest 50 points
          }
        }
      },
      onError: (error) {
        print("WebSocket error: $error");
      },
      onDone: () {
        print("WebSocket connection closed");
      },
    );
  }

  void disconnectWebSocket() {
    channel.sink.close(status.normalClosure);
  }

  @override
  void onClose() {
    disconnectWebSocket();
    super.onClose();
  }
}
