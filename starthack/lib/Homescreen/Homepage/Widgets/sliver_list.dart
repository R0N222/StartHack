import 'dart:io';

import 'package:flutter/material.dart';
import 'package:starthack/shared/StockPictures.dart';
import 'package:starthack/shared/Data.dart';
import 'package:starthack/Homescreen/Homescreen.dart';
import '../../Declarations/constants.dart';
import 'dart:math';

class SliverListBldr extends StatelessWidget {
  SliverListBldr({
    Key? key,
  }) : super(key: key);

  List<StockListElement> top20 = [
    StockListElement(name: 'Tesla'),
    StockListElement(name: 'Apple'),
    StockListElement(name: 'Amazon'),
    StockListElement(name: 'Microsoft'),
    StockListElement(name: 'Nvidia'),
    StockListElement(name: 'Netflix'),
    StockListElement(name: 'Intel'),
    StockListElement(name: 'Meta'),
    StockListElement(name: 'Pepsico'),
    StockListElement(name: 'Adobe'),
    StockListElement(name: 'amd'),
    StockListElement(name: 'comcast'),
    StockListElement(name: 'qualcomm'),
    StockListElement(name: 'honeywell'),
    StockListElement(name: 'intuit'),
  ];

  var rd=Random();
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == 0 && myWatchList.length > 0) {
            return Column(children: [
              TextSeperatorWidget(text: "My Watchlist"),
              StockListElement(name: myWatchList[index]),
            ]);
          } else if (index < myWatchList.length) return StockListElement(name: myWatchList[index]);
          if (index == myWatchList.length) {
            return Column(
              children: [
                TextSeperatorWidget(text: "Discovery"),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
                top20.elementAt(rd.nextInt(15)),
              ],
            );
          } else {
            return StockListElement(name: "amazon");
          }
        },
        childCount: 20,
      ),
    );
  }
}
