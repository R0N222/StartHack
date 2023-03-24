import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:starthack/Stock/APICall.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/shared/AI.dart';
import 'package:starthack/shared/Data.dart';
import 'package:http/http.dart' as http;


class BigLineChart extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFlSpot(currentStock),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error");
          if (!snapshot.hasData) return CircularProgressIndicator();
          List<FlSpot> values = snapshot.data!;

          double minx = 10000000;
          double maxx = 0;
          double miny = 10000000;
          double maxy = 0;
          print("Values " + "${values.length}");
          for (int i = 0; i < values.length; i++) {
            if (minx > values[i].x) minx = values[i].x;
            if (miny > values[i].y) miny = values[i].y;
            if (maxx < values[i].x) maxx = values[i].x;
            if (maxy < values[i].y) maxy = values[i].y;
          }
          return LineChart(
            LineChartData(
                minX: minx,
                maxX: maxx,
                minY: miny,
                maxY: maxy,
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Color.fromRGBO(0, 0, 0, 0),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: values,
                    isCurved: true,
                    //gradient: LinearGradient(colors: gradientColors),
                    color: Color(0xff7d53fe),
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                  ),
                ],
                gridData: FlGridData(
                  drawHorizontalLine: false,
                  drawVerticalLine: true,
                  getDrawingVerticalLine: (value) => VerticalLine(x: 3, color: Color(0xff6B25F4)),
                )),
          );
        });
  }
}

class StockScreenWidget extends StatefulWidget {
  final String name;
  final double percent;
  const StockScreenWidget({super.key, required this.name, required this.percent});

  @override
  State<StockScreenWidget> createState() => _StockScreenWidgetState();
}

double eps_tmp=0.0;

class _StockScreenWidgetState extends State<StockScreenWidget> {
  bool inwlist = false;

  @override
  Widget build(BuildContext context) {
    inwlist = isOnWatchlist(widget.name);

    return Scaffold(
      body: Stack(children: [
        new Container(
          color: Color(0xfff7f7f7),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                // Chart here
                return Container(
                  child: Stack(children: [
                    Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('https://logo.clearbit.com/' + widget.name + '.com'),
                          ),
                          margin: EdgeInsets.only(left: 30, top: 20),
                        ),
                        Container(
                          child: Text(widget.name, style: TextStyle(fontSize: 23, color: Color(0xffccc8d8))),
                          margin: EdgeInsets.only(left: 10, top: 20),
                        ),
                        Container(
                            child: IconButton(
                              icon: Image.asset(inwlist ? 'assets/images/InWhitelistButton.png' : 'assets/images/AddToWatchlistButton.png'),
                              onPressed: () {
                                if (!inwlist)
                                  addToWatchList(widget.name);
                                else
                                  removeToWatchList(widget.name);

                                setState(() {
                                  inwlist = !inwlist;
                                });
                              },
                              hoverColor: Color.fromARGB(0, 75, 49, 124),
                              iconSize: 36,
                            ),
                            margin: EdgeInsets.only(top: 20)),
                        Container(
                          child: Tooltip(
                              message: '${widget.name} has attained a performance of +${widget.percent}% within the last year.',
                              showDuration: const Duration(seconds: 1000),
                              triggerMode: TooltipTriggerMode.tap,
                              padding: const EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 50, right: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(colors: <Color>[Color.fromARGB(255, 255, 156, 7), Color.fromARGB(255, 244, 105, 54)]),
                              ),
                              child: Text((widget.percent < 0 ? '-${widget.percent}%' : '+${widget.percent}%'), style: TextStyle(fontSize: 22, color: Color(0xffccc8d8)))),
                          width: 80,
                          margin: EdgeInsets.only(left: 60, top: 23),
                        ),
                        Container(
                          child: Container(
                            child: Image.asset(widget.percent < 0 ? 'assets/images/ArrowDownWhite.png' : 'assets/images/ArrowUpWhite.png'),
                            width: 1,
                            height: 20,
                          ),
                          width: 20,
                          margin: EdgeInsets.only(left: 0, top: 23),
                        )
                      ],
                    ),
                    Container(
                      child: Tooltip(
                          message: '${widget.name} has attained a performance of +${widget.percent}% within the last year.',
                          showDuration: const Duration(seconds: 1000),
                          triggerMode: TooltipTriggerMode.tap,
                          padding: const EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(left: 50, right: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(colors: <Color>[Color.fromARGB(255, 255, 156, 7), Color.fromARGB(255, 244, 105, 54)]),
                          ),
                          child: Stack(
                            children: [BigLineChart(), Container(color: Colors.redAccent.withOpacity(0))],
                          )),
                      height: 170,
                      margin: EdgeInsets.only(top: 100),
                    ),
                    Container(
                      child: Text('191,15€', style: TextStyle(fontSize: 37, color: Color(0xfff7f7f7))),
                      margin: EdgeInsets.only(left: 40, top: 65),
                    ),
                    Container(
                      child: Row(
                        children: [
                          MaterialButton(onPressed: () {}, child: Text('1W', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                          MaterialButton(onPressed: () {}, child: Text('1M', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                          MaterialButton(onPressed: () {}, child: Text('3M', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                          MaterialButton(onPressed: () {}, child: Text('1Y', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                          MaterialButton(onPressed: () {}, child: Text('all', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      width: 320,
                      margin: EdgeInsets.only(top: 250, left: 45),
                    ),
                  ]),
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)), color: Color(0xff6E28F9)),
                );
              case 1:
                // Summary here
                return SummaryWidget(name: widget.name);
              case 2:
                return SectorWidget(sector: 'Automobile');
              case 3:
                void func() async {
                  var response = await ApiService.getData(widget.name);
                  eps_tmp = double.parse(response); 
                  print("EPS: $eps_tmp");
                }
                func();
                return EPSWidget(eps: eps_tmp);

                
              case 4:
                return PEWidget(pe: 50.58);
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

class SectorWidget extends StatelessWidget {
  final String sector;

  const SectorWidget({super.key, required this.sector});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Stack(
            children: [
              Container(
                child: Text(sector, style: TextStyle(color: Color(0xff6e28f9), fontSize: 25)),
                margin: EdgeInsets.only(left: 30, top: 40),
              ),
              Container(
                child: Text('Business sector', style: TextStyle(color: Color(0xff65616d), fontSize: 17)),
                margin: EdgeInsets.only(left: 30, top: 73),
              ),
              Container(
                  child: Tooltip(
                      message: 'A business sector is a group of related businesses in the same industry.',
                      showDuration: const Duration(seconds: 1000),
                      triggerMode: TooltipTriggerMode.tap,
                      padding: const EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(left: 50, right: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: <Color>[Color.fromARGB(255, 255, 156, 7), Color.fromARGB(255, 244, 105, 54)]),
                      ),
                      child: Image.asset('assets/images/EPS-Picture.png')),
                  margin: EdgeInsets.only(left: 220, top: 15),
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF0F0F4),
                  )),
            ],
          ),
          height: 140,
          width: 350,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xfff7f7f7),
          )),
    );
  }
}

class EPSWidget extends StatelessWidget {
  final double eps;

  const EPSWidget({super.key, required this.eps});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Stack(
            children: [
              Container(
                child: Text('$eps€', style: TextStyle(color: Color(0xff6e28f9), fontSize: 28)),
                margin: EdgeInsets.only(left: 30, top: 36),
              ),
              Container(
                child: Text('eps', style: TextStyle(color: Color(0xff6e28f9), fontSize: 20)),
                margin: EdgeInsets.only(left: 142, top: 43),
              ),
              Container(
                child: Text('Earnings per share', style: TextStyle(color: Color(0xff65616d), fontSize: 17)),
                margin: EdgeInsets.only(left: 30, top: 73),
              ),
              Container(
                  child: Tooltip(
                      message: 'A single Tesla share generates a net profit of 0.95€ per year.',
                      showDuration: const Duration(seconds: 1000),
                      triggerMode: TooltipTriggerMode.tap,
                      padding: const EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(left: 50, right: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: <Color>[Color.fromARGB(255, 255, 156, 7), Color.fromARGB(255, 244, 105, 54)]),
                      ),
                      child: Image.asset('assets/images/EPS-Picture.png')),
                  margin: EdgeInsets.only(left: 220, top: 15),
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF0F0F4),
                  )),
            ],
          ),
          height: 140,
          width: 350,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xfff7f7f7),
          )),
    );
  }
}

class PEWidget extends StatelessWidget {
  final double pe;

  const PEWidget({super.key, required this.pe});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Stack(
            children: [
              Container(
                child: Text('$pe', style: TextStyle(color: Color(0xff6e28f9), fontSize: 28)),
                margin: EdgeInsets.only(left: 30, top: 36),
              ),
              Container(
                child: Text('P/E ratio', style: TextStyle(color: Color(0xff6e28f9), fontSize: 20)),
                margin: EdgeInsets.only(left: 130, top: 43),
              ),
              Container(
                child: Text('Price-to-Earnings Ratio', style: TextStyle(color: Color(0xff65616d), fontSize: 17)),
                margin: EdgeInsets.only(left: 30, top: 73),
              ),
              Container(
                  child: Tooltip(
                      message: 'At constant earnings, it takes 50.58 years for a Tesla share to earn back its current purchase price.',
                      showDuration: const Duration(seconds: 1000),
                      triggerMode: TooltipTriggerMode.tap,
                      padding: const EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(left: 50, right: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: <Color>[Color.fromARGB(255, 255, 156, 7), Color.fromARGB(255, 244, 105, 54)]),
                      ),
                      child: Image.asset('assets/images/EPS-Picture.png')),
                  margin: EdgeInsets.only(left: 220, top: 15),
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF0F0F4),
                  )),
            ],
          ),
          height: 140,
          width: 350,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xfff7f7f7),
          )),
    );
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
            Container(
                child: Tooltip(
                    message: "Here is a brief summary of Tesla's business model written by AI.",
                    showDuration: const Duration(seconds: 1000),
                    triggerMode: TooltipTriggerMode.tap,
                    padding: const EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(left: 50, right: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(colors: <Color>[Color.fromARGB(255, 255, 156, 7), Color.fromARGB(255, 244, 105, 54)]),
                    ),
                    child: Image.asset('assets/images/AI_Icon.png', width: 90, height: 90)),
                margin: EdgeInsets.only(top: 20, right: 285),
                height: 50),
            FutureBuilder(
              future: summarize(name),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Text(snapshot.data.toString(), style: TextStyle(fontSize: 18)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      color: Color(0xfff7f7f7),
      height: 250,
    );
  }
}
