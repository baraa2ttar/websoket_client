import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/view/home_screen/price_track_controller.dart';

class ChannelManagementPage extends StatelessWidget {
  final PriceTrackerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: controller.disconnectWebSocket,
            child: Text('Disconnect WebSocket'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.connectToWebSocket,
            child: Text('Reconnect WebSocket'),
          ),
        ],
      ),
    );
  }
}
