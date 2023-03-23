import 'dart:io';

import 'package:flutter/material.dart';
import 'package:starthack/shared/StockPictures.dart';
import 'package:starthack/shared/Data.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < myWatchList.length) return StockListElement(name: myWatchList[index]);
          if (index == myWatchList.length) {
            return Column(
              children: [
                Container(
                  height: 60,
                  child: Container(
                    child: Text(
                      "Discovery",
                      style: TextStyle(fontSize: 20),
                    ),
                    margin: EdgeInsets.only(left: 10, top: 20),
                  ),
                ),
                StockListElement(name: "Tesla"),
              ],
            );
          } else {
            return StockListElement(name: "Tesla");
          }
        },
        padding: EdgeInsets.only(top: 300),
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
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://logo.clearbit.com/' + name + '.com'),
                ),
                margin: EdgeInsets.only(left: 20),
              ),
              Container(
                child: Text(
                  name,
                ),
                margin: EdgeInsets.only(left: 50, top: 10),
              )
            ],
          ),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/stock');
        },
      ),
    );
  }
}
