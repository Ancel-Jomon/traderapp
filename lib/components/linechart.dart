
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartClass {
  static LineChart linechart(Map<DateTime, double> data) {
    int i = -1;
    final datelist = data.keys.toList();
    double maxY = data.entries
        .reduce(
          (value, element) {
            return value.value > element.value ? value : element;
          },
        )
        .value
        .toDouble();
    maxY = maxY + maxY / 4;

    return LineChart(LineChartData(
        maxX: 7,
        minY: 0,
        minX: -1,
        maxY: maxY,
        gridData: const FlGridData(
          drawHorizontalLine: true,
          drawVerticalLine: false,
          //horizontalInterval: 80,
          //verticalInterval: 10
        ),
        borderData: FlBorderData(
            show: true,
            border: const Border(
                bottom: BorderSide(width: 3), left: BorderSide(width: 3))),
        titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              reservedSize: 50,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == meta.max) {
                  return Container();
                } else {
                  return Text(value.toStringAsFixed(0));
                }
              },
            )),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              //interval: 10,
              reservedSize: 30,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value >= 0 && datelist.length > value) {
                  switch (value) {
                    case 0:
                      return Text(DateFormat('d').format(datelist[0]));
                    case 1:
                      return Text(DateFormat('d').format(datelist[1]));
                    case 2:
                      return Text(DateFormat('d').format(datelist[2]));
                    case 3:
                      return Text(DateFormat('d').format(datelist[3]));
                    case 4:
                      return Text(DateFormat('d').format(datelist[4]));
                    case 5:
                      return Text(DateFormat('d').format(datelist[5]));
                    case 6:
                      return Text(DateFormat('d').format(datelist[6]));

                    default:
                      return const Text('');
                  }
                }
                return const Text('');
              },
            ))),
        lineBarsData: [
          LineChartBarData(
              spots: data.entries.map((e) {
            i++;
            return FlSpot(i.toDouble(), e.value.toDouble());
          }).toList())
        ]));
  }
}
