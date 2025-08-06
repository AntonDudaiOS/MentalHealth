import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_mental_health_app/core/models/chart_data.dart';

class TestResultsChartWidget extends StatelessWidget {
  final List<ChartPoint> points;

  const TestResultsChartWidget({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox.shrink();
    }

    final sorted = [...points]..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    final minY = sorted.map((r) => r.score).reduce((a, b) => a < b ? a : b).toDouble();
    final maxY = sorted.map((r) => r.score).reduce((a, b) => a > b ? a : b).toDouble();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= sorted.length) return const SizedBox.shrink();
                  final label = DateFormat('dd.MM').format(sorted[index].timestamp);
                  return Text(label, style: const TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                sorted.length,
                (index) => FlSpot(index.toDouble(), sorted[index].score.toDouble()),
              ),
              isCurved: true,
              color: Colors.blueAccent,
              barWidth: 2,
              dotData: FlDotData(show: true),
            )
          ],
          minY: minY - 1,
          maxY: maxY + 1,
          minX: 0,
          maxX: sorted.length.toDouble() - 1,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}
