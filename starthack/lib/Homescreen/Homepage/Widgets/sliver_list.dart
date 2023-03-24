import 'dart:io';

import 'package:flutter/material.dart';
import 'package:starthack/shared/StockPictures.dart';
import 'package:starthack/shared/Data.dart';
import 'package:starthack/Homescreen/Homescreen.dart';
import '../../Declarations/constants.dart';

class SliverListBldr extends StatelessWidget {
  SliverListBldr({
    Key? key,
  }) : super(key: key);

  List<StockListElement> top20 = [
    StockListElement(name: 'Tesla'),
    StockListElement(name: 'Tesla')
  ];

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
                StockListElement(name: "Tesla"),
              ],
            );
          } else {
            return StockListElement(name: "Amazon");
          }
        },
        childCount: 20,
      ),
    );
  }
}
