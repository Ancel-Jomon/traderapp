
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/linechart.dart';
import 'package:traderapp/services/firestoreingishts.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: FirestoreInsights().thismonthorderdata(false),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                log(snapshot.data!.$2.toString());
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
                              child: LineChartClass.linechart(snapshot.data!.$2),
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

  
}
