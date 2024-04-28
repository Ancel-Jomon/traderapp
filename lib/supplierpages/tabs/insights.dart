import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/services/firestoreingishts.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreInsights().getorderdata(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
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
                          PieChartSectionData(value: 10, color: Colors.amber),
                          PieChartSectionData(value: 40, color: Colors.blue),
                          PieChartSectionData(value: 50, color: Colors.green)
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
                        '\$3000',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
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
                    child: LineChart(LineChartData(
                        maxX: 8,
                        minY: 0,
                        minX: 0,
                        maxY: 12,
                        lineBarsData: [
                          LineChartBarData(spots: [
                            const FlSpot(1, 5),
                            const FlSpot(3, 10),
                            const FlSpot(5, 4),
                            const FlSpot(6, 7),
                            const FlSpot(7, 3)
                          ])
                        ]))))
          ],
        ),
      ),
    );
  }
}
