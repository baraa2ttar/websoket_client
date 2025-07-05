import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:websoket/core/constant/app_color.dart';
import 'package:websoket/view/home_screen/Home_controller/price_track_controller.dart';

class PriceChartWidget extends StatelessWidget {
  final PriceTrackerController controller;

  const PriceChartWidget({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price History',
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: controller.clearHistory,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(child: Obx(() => _buildLineChart())),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    if (controller.priceHistory.isEmpty) {
      return _buildEmptyState();
    }

    return LineChart(
      LineChartData(
        gridData: _buildGridData(),
        titlesData: _buildTitlesData(),
        borderData: _buildBorderData(),
        minX: 0,
        maxX: (controller.priceHistory.length - 1).toDouble(),
        minY: controller.lowestPrice.value * 0.95,
        maxY: controller.highestPrice.value * 1.05,
        lineBarsData: [_buildLineChartBarData()],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 64, color: AppColor.textLight),
          const SizedBox(height: 16),
          Text(
            'No price data yet',
            style: Get.textTheme.bodyLarge?.copyWith(
              color: AppColor.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Connect to WebSocket to see price history',
            style: Get.textTheme.bodySmall?.copyWith(color: AppColor.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(color: AppColor.border, strokeWidth: 1);
      },
      getDrawingVerticalLine: (value) {
        return FlLine(color: AppColor.border, strokeWidth: 1);
      },
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            return Text(
              '\$${value.toStringAsFixed(1)}',
              style: TextStyle(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          },
          reservedSize: 42,
        ),
      ),
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(show: true, border: Border.all(color: AppColor.border));
  }

  LineChartBarData _buildLineChartBarData() {
    return LineChartBarData(
      spots: _getChartSpots(),
      isCurved: true,
      gradient: AppColor.primaryGradient,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            AppColor.primary.withOpacity(0.3),
            AppColor.primary.withOpacity(0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  List<FlSpot> _getChartSpots() {
    return controller.priceHistory.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['price'].toDouble());
    }).toList();
  }
}
