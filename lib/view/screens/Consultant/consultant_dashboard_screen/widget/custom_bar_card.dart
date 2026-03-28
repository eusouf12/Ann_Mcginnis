import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum ChartFilter { year }

class CustomBarChartCard extends StatefulWidget {
  final String title;
  final Map<ChartFilter, List<double>> data;
  const CustomBarChartCard({super.key, required this.title, required this.data});

  @override
  State<CustomBarChartCard> createState() => _CustomBarChartCardState();
}

class _CustomBarChartCardState extends State<CustomBarChartCard> {
  ChartFilter selectedFilter = ChartFilter.year;

  List<String> get labels => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  List<double> get values => widget.data[selectedFilter] ?? List.filled(12, 0.0);

  @override
  Widget build(BuildContext context) {
    final chartValues = values;
    final chartLabels = labels;
    double maxVal = chartValues.isEmpty ? 0 : chartValues.reduce((a, b) => a > b ? a : b);
    double dynamicMaxY = maxVal > 130 ? (maxVal + 50) : 150;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              // This Year Button
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
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Chart Section
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                maxY: dynamicMaxY,
                minY: 0,
                barGroups: _barGroups(chartValues),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  horizontalInterval: 50,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.15),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
                titlesData: _titlesData(chartLabels),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _barGroups(List<double> data) {
    return List.generate(data.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i],
            width: 14,
            color: AppColors.yellow1,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  FlTitlesData _titlesData(List<String> labels) {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          interval: 50,
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

      // X-axis
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
                  style: const TextStyle(color: Colors.white70, fontSize: 10)
              ),
            );
          },
        ),
      ),
    );
  }
}
