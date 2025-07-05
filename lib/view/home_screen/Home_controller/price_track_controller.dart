import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class PriceTrackerController extends GetxController {
  late WebSocketChannel channel;

  // Observable variables
  var currentPrice = "0.00".obs;
  var lastUpdate = "Never".obs;
  var connectionStatus = "Disconnected".obs;
  var isConnected = false.obs;
  var isLoading = false.obs;
  var priceHistory = <Map<String, dynamic>>[].obs;
  var serverUrl = "ws://localhost:8080".obs;
  var errorMessage = "".obs;

  // Price statistics
  var priceChange = 0.0.obs;
  var priceChangePercent = 0.0.obs;
  var highestPrice = 0.0.obs;
  var lowestPrice = double.infinity.obs;
  var averagePrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      connectionStatus.value = "Connecting...";

      channel = WebSocketChannel.connect(Uri.parse(serverUrl.value));

      channel.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error) {
          _handleError(error.toString());
        },
        onDone: () {
          _handleDisconnection();
        },
      );

      isConnected.value = true;
      connectionStatus.value = "Connected";
      isLoading.value = false;
    } catch (e) {
      _handleError(e.toString());
    }
  }

  void _handleMessage(dynamic message) {
    try {
      currentPrice.value = message.toString();
      lastUpdate.value = _formatDateTime(DateTime.now());

      double? price = double.tryParse(message.toString());
      if (price != null) {
        _updatePriceHistory(price);
        _updatePriceStatistics(price);
      }
    } catch (e) {
      errorMessage.value = "Error processing message: $e";
    }
  }

  void _updatePriceHistory(double price) {
    priceHistory.add({'price': price, 'time': DateTime.now()});

    // Keep only the latest 100 points
    if (priceHistory.length > 100) {
      priceHistory.removeAt(0);
    }
  }

  void _updatePriceStatistics(double newPrice) {
    if (priceHistory.length > 1) {
      double previousPrice = priceHistory[priceHistory.length - 2]['price'];
      priceChange.value = newPrice - previousPrice;
      priceChangePercent.value =
          ((newPrice - previousPrice) / previousPrice) * 100;
    }

    if (newPrice > highestPrice.value) {
      highestPrice.value = newPrice;
    }

    if (newPrice < lowestPrice.value) {
      lowestPrice.value = newPrice;
    }

    // Calculate average price
    double total = priceHistory.fold(0.0, (sum, item) => sum + item['price']);
    averagePrice.value = total / priceHistory.length;
  }

  void _handleError(String error) {
    isConnected.value = false;
    connectionStatus.value = "Error";
    errorMessage.value = error;
    isLoading.value = false;
    print("WebSocket error: $error");
  }

  void _handleDisconnection() {
    isConnected.value = false;
    connectionStatus.value = "Disconnected";
    isLoading.value = false;
    print("WebSocket connection closed");
  }

  void disconnectWebSocket() {
    try {
      channel.sink.close(status.normalClosure);
      isConnected.value = false;
      connectionStatus.value = "Disconnected";
    } catch (e) {
      print("Error disconnecting: $e");
    }
  }

  void updateServerUrl(String newUrl) {
    serverUrl.value = newUrl;
    if (isConnected.value) {
      disconnectWebSocket();
    }
    connectToWebSocket();
  }

  void clearError() {
    errorMessage.value = "";
  }

  void clearHistory() {
    priceHistory.clear();
    highestPrice.value = 0.0;
    lowestPrice.value = double.infinity;
    averagePrice.value = 0.0;
    priceChange.value = 0.0;
    priceChangePercent.value = 0.0;
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    disconnectWebSocket();
    super.onClose();
  }
}
