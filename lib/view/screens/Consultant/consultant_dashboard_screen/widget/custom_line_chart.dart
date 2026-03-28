import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'custom_bar_card.dart';

class CustomLineChartCard extends StatefulWidget {
  final String title;
  final Map<ChartFilter, List<double>> data;
  const CustomLineChartCard({super.key, required this.title, required this.data});

  @override
  State<CustomLineChartCard> createState() => _CustomLineChartCardState();
}

class _CustomLineChartCardState extends State<CustomLineChartCard> {
  ChartFilter selectedFilter = ChartFilter.year;

  List<String> get labels => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  List<double> get values => widget.data[selectedFilter] ?? List.filled(12, 0.0);

  @override
  Widget build(BuildContext context) {
    final chartValues = values;
    final chartLabels = labels;

    // সর্বোচ্চ ভ্যালু বের করা
    double maxVal = chartValues.isEmpty ? 0 : chartValues.reduce((a, b) => a > b ? a : b);

    // যেহেতু আপনি ১০ ঘর পর পর চাচ্ছেন, তাই maxY কে ১০ এর গুণিতক হিসেবে রাখা ভালো
    // যদি সর্বোচ্চ ডাটা ১২ হয়, তবেmaxY হবে ৫০, যাতে ১০, ২০, ৩০, ৪০ ঘরগুলো সুন্দর দেখায়
    double dynamicMaxY = maxVal > 40 ? (maxVal + 20) : 50;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1), // গাঢ় নীল ব্যাকগ্রাউন্ড
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // "This Year" বাটন স্টাইল
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  "This Year",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          /// Line Chart Section
          AspectRatio(
            aspectRatio: 1.4,
            child: LineChart(
              LineChartData(
                maxY: dynamicMaxY,
                minY: 0,
                minX: 0,
                maxX: 11,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  horizontalInterval: 10, // ১০ ঘর পর পর হরিজন্টাল লাইন
                  verticalInterval: 1,    // প্রতি মাসে একটি ভার্টিকাল লাইন
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.15),
                    strokeWidth: 1,
                    dashArray: [5, 5], // ভার্টিকাল ডট ইফেক্ট
                  ),
                ),
                titlesData: _titlesData(chartLabels),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _getSpots(chartValues),
                    isCurved: true, // লাইনটি হালকা বাঁকানো থাকবে
                    curveSmoothness: 0.3,
                    color: AppColors.yellow1,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.yellow1,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.yellow1.withOpacity(0.1), // লাইনের নিচে হালকা শ্যাডো
                    ),
                  ),
                ],
                // টাচ করলে ডাটা দেখাবে
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.white,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toInt()} Bookings',
                          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ডাটাকে Spots এ কনভার্ট করা
  List<FlSpot> _getSpots(List<double> data) {
    return List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i]));
  }

  // Titles (Axis Labels) সেটিংস
  FlTitlesData _titlesData(List<String> labels) {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          interval: 10, // বাম পাশে ১০ করে গ্যাপ (০, ১০, ২০, ৩০...)
          getTitlesWidget: (value, meta) {
            return SideTitleWidget(
              meta: meta,
              child: Text(
                '${value.toInt()}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index < 0 || index >= labels.length) return const SizedBox.shrink();
            return SideTitleWidget(
              meta: meta,
              child: Text(
                labels[index],
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
            );
          },
        ),
      ),
    );
  }
}