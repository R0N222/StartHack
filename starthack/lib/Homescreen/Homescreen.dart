import 'dart:io';

import 'package:flutter/material.dart';
import 'package:starthack/main.dart';
import 'package:starthack/shared/StockPictures.dart';
import 'package:starthack/shared/Data.dart';
import 'package:starthack/Stock/Chart.dart';

/*
class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: const Color.fromARGB(255, 135, 33, 243),
        ),
        Container(
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              margin: EdgeInsets.only(top: 300),
            ),
            Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0 && myWatchList.length > 0) {
                    return Column(children: [
                      Container(
                        height: 350,
                      ),
                      TextSeperatorWidget(text: "My Watchlist"),
                      StockListElement(name: myWatchList[index]),
                    ]);
                  } else if (index < myWatchList.length) return StockListElement(name: myWatchList[index]);
                  if (index == myWatchList.length) {
                    return Column(
                      children: [
                        TextSeperatorWidget(text: "Discovery"),
                        StockListElement(name: "Tesla"),
                      ],
                    );
                  } else {
                    return StockListElement(name: "Tesla");
                  }
                },
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}*/

class TextSeperatorWidget extends StatelessWidget {
  final String text;
  const TextSeperatorWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Container(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        margin: const EdgeInsets.only(left: 25, top: 10),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

class StockListElement extends StatelessWidget {
  final String name;
  const StockListElement({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://logo.clearbit.com/' + name + '.com'),
                    ),
                    margin: EdgeInsets.only(left: 20),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          name,
                        ),
                        margin: EdgeInsets.only(left: 50, top: 15),
                        width: 100,
                      ),
                      Container(
                        child: Text(
                          "19.99 €",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: const Color.fromARGB(255, 26, 25, 28)),
                        ),
                        margin: EdgeInsets.only(left: 50, top: 5),
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
              ChartViewHomepageWidget(values: [3, 3234, 342, 32], percent: 10),
            ],
          ),
          height: 80, // 1080 * 2400
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 244),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        onTap: () {
          currentStock = name;
          Navigator.pushNamed(context, '/stock');
        },
      ),
    );
  }
}

class ChartViewHomepageWidget extends StatelessWidget {
  final List<double> values;
  final double percent;

  const ChartViewHomepageWidget({super.key, required this.values, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            child: SmallChartWidget(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: 120),
        Container(
          child: Text("$percent%"),
          width: 90,
          height: 90,
          alignment: Alignment.bottomRight,
        ),
        Container(
          child: Container(
            child: Image.asset(percent < 0 ? 'assets/images/ArrowDown.png' : 'assets/images/ArrowUp.png'),
            width: 9,
            height: 40,
          ),
          alignment: Alignment.bottomRight,
          width: 102,
        )
      ],
    );
  }
}

class SmallChartWidget extends StatelessWidget {
  const SmallChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmallLineChartWidget(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: const Color.fromARGB(255, 240, 240, 244),
      ),
    );
  }
}
