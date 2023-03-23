import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/shared/AI.dart';

class StockScreenWidget extends StatelessWidget {
  final String name;
  const StockScreenWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        new Container(
          color: Colors.white,
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                // Chart here
                return Container(
                  height: 300,
                );
              case 1:
                // Summary here
                return SummaryWidget(name: name);
              default:
                return Container(
                  height: 300,
                );
            }
          },
        ),
      ]),
    ); //LineChartWidget()
  }
}

class SummaryWidget extends StatelessWidget {
  final String name;

  const SummaryWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(Text("Summary")),
            FutureBuilder(
              future: summarize(name),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Text(snapshot.data.toString()),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      color: Color.fromARGB(255, 230, 229, 229),
      height: 200,
    );
  }
}
