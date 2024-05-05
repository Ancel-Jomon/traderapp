

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
                return Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Column(
                          children: [
                            Card(
                              color: Colors.blue,
                              child: Text('₹ ${
                                snapshot.data!.$1.toString()}',
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
