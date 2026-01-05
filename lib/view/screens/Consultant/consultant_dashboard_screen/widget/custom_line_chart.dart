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
  ChartFilter selectedFilter = ChartFilter.week;

  String get filterText {
    switch (selectedFilter) {
      case ChartFilter.week:
        return "This Week";
      case ChartFilter.month:
        return "This Month";
      case ChartFilter.year:
        return "This Year";
    }
  }

  List<String> get labels {
    switch (selectedFilter) {
      case ChartFilter.week:
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case ChartFilter.month:
        final weeksCount = widget.data[ChartFilter.month]?.length ?? 4;
        return List.generate(weeksCount, (i) => 'W${i + 1}');
      case ChartFilter.year:
        return ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    }
  }

  List<double> get values => widget.data[selectedFilter] ?? [];

  @override
  Widget build(BuildContext context) {
    final chartValues = values;
    final chartLabels = labels;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A3B8E), // আপনার ইমেজ অনুযায়ী গাঢ় নীল রং
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),

              /// Dropdown
              PopupMenuButton<ChartFilter>(
                onSelected: (value) => setState(() => selectedFilter = value),
                itemBuilder: (_) => [
                  _menuItem("This Week", ChartFilter.week),
                  _menuItem("This Month", ChartFilter.month),
                  _menuItem("This Year", ChartFilter.year),
                ],
                child: _dropdownButton(),
              ),
            ],
          ),

          const SizedBox(height: 30),

          /// Line Chart
          AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                maxY: 100,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: _titlesData(chartLabels),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _getSpots(chartValues),
                    isCurved: false, // ইমেজ অনুযায়ী সোজা রেখা, চাইলে true করতে পারেন
                    color: AppColors.yellow1,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true), // পয়েন্টগুলো দেখানোর জন্য
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ডেটাকে ম্যাপ করে পয়েন্ট (Spots) তৈরি করা
  List<FlSpot> _getSpots(List<double> data) {
    return List.generate(data.length, (i) {
      return FlSpot(i.toDouble(), data[i].clamp(0, 100));
    });
  }

  Widget _dropdownButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(filterText, style: const TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black),
        ],
      ),
    );
  }

  PopupMenuItem<ChartFilter> _menuItem(String text, ChartFilter value) {
    return PopupMenuItem(
      value: value,
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }

  FlTitlesData _titlesData(List<String> labels) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          reservedSize: 45,
          getTitlesWidget: (value, meta) {
            if (value > 100) return const SizedBox.shrink();

            String text = '${value.toInt()}k';
            if (value.toInt() == 100) {
              text = '100k+'; // আপনার রিকোয়ারমেন্ট অনুযায়ী
            }

            return SideTitleWidget(
              meta: meta,
              child: Text(text,
                  style: const TextStyle(color: Colors.white60, fontSize: 10)),
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
              child: Text(labels[index],
                  style: const TextStyle(color: Colors.white60, fontSize: 10)),
            );
          },
        ),
      ),
    );
  }
}