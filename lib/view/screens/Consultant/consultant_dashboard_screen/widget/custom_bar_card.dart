import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum ChartFilter { week, month, year }

class CustomBarChartCard extends StatefulWidget {
  final String title;
  final Map<ChartFilter, List<double>> data; // dynamic values
  const CustomBarChartCard({super.key, required this.title, required this.data});

  @override
  State<CustomBarChartCard> createState() => _CustomBarChartCardState();
}

class _CustomBarChartCardState extends State<CustomBarChartCard> {
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
        return ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
      case ChartFilter.month:
        final weeksCount = widget.data[ChartFilter.month]?.length ?? 4;
        return List.generate(weeksCount, (i) => 'Week ${i + 1}');
      case ChartFilter.year:
        return ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    }
  }

  List<double> get values {
    return widget.data[selectedFilter] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final chartValues = values;
    final chartLabels = labels;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1),
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

          /// Horizontal Bar Chart
          AspectRatio(
            aspectRatio: 1.3,
            child: BarChart(
              BarChartData(
                maxY: 100,
                minY: 0,
                barGroups: _barGroups(chartValues),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.2),
                    strokeWidth: 1,
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

  List<BarChartGroupData> _barGroups(List<double> data) {
    return List.generate(data.length, (i) {
      // Jodi value 100 er beshi hoy, tobe eti 100 e theme thakbe
      final double displayValue = data[i].clamp(0.0, 100.0);

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: displayValue, // Cap at 100
            width: selectedFilter == ChartFilter.year ? 12 : 20, // Year hole bar thin hobe jate overlap na kore
            color: AppColors.yellow1,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ],
      );
    });
  }

  FlTitlesData _titlesData(List<String> labels) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            if (value > 100) return const SizedBox.shrink();

            String text = '${value.toInt()}k';
            // 100k er jaygay 100k+ dekhabe
            if (value.toInt() == 100) {
              text = '100k+';
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
            if (value.toInt() < 0 || value.toInt() >= labels.length) return const SizedBox.shrink();
            return SideTitleWidget(
              meta: meta,
              child: Text(labels[value.toInt()],
                  style: const TextStyle(color: Colors.white60, fontSize: 10)),
            );
          },
        ),
      ),
    );
  }

}
