import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traderapp/services/firestoreingishts.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: FirestoreInsights.thismonthorderdata(true),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Card(
                          child: SizedBox(
                            width: 170,
                            height: 170,
                            child: PieChart(PieChartData(
                                borderData: FlBorderData(show: false),
                                sections: [
                                  PieChartSectionData(
                                      value: 10, color: Colors.amber),
                                  PieChartSectionData(
                                      value: 40, color: Colors.blue),
                                  PieChartSectionData(
                                      value: 50, color: Colors.green)
                                ])),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Card(
                              color: Colors.blue,
                              child: Text(
                                snapshot.data!.$1.toString(),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 50),
                              ),
                            ),
                            const Text('total sales')
                          ],
                        )
                      ],
                    ),
                    Card(
                        child: SizedBox(
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: linechart(snapshot.data!.$2),
                            )))
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget linechart(Map<DateTime, int> data) {
    int i = -1;
    final datelist = data.keys.toList();
    log(datelist.toString());
    double maxY = data.entries
        .reduce(
          (value, element) {
            return value.value > element.value ? value : element;
          },
        )
        .value
        .toDouble();
    maxY = maxY + maxY / 4;

    double minY = data.entries
        .reduce(
          (value, element) {
            return value.value < element.value ? value : element;
          },
        )
        .value
        .toDouble();
    minY = minY - minY / 4;

    return LineChart(LineChartData(
        maxX: 8,
        minY: minY,
        minX: -1,
        maxY: maxY,
        gridData: const FlGridData(show: false),
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
              reservedSize: 30,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == minY) {
                  return Text(minY.toString());
                } else {
                  return const Text('');
                }
              },
            )),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              reservedSize: 30,
              showTitles: true,
              getTitlesWidget: (value, meta) {
              if(value>0 && value<datelist.length){
                 return Text(DateFormat('Md').format(datelist[value.toInt()]));
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
