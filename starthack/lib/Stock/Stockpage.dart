import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/shared/AI.dart';

class BigLineChart extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Color.fromRGBO(0, 0, 0, 0),
              
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 2.5),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              //gradient: LinearGradient(colors: gradientColors),
              color: Color(0xff7d53fe),
              barWidth: 3,
              dotData: FlDotData(show: false),
              
            ),
          ],
          gridData: FlGridData(drawHorizontalLine: false, drawVerticalLine: true, getDrawingVerticalLine: (value) => VerticalLine(x: 3, color: Color(0xff6B25F4)), )
        ),
        
      );
}

class StockScreenWidget extends StatelessWidget {
  final String name;
  final double percent;
  const StockScreenWidget({super.key, required this.name, required this.percent});

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
                  child: 
                  Stack(children: [
                    Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('https://logo.clearbit.com/' + name + '.com'),
                          ),
                          margin: EdgeInsets.only(left: 30, top: 20),
                        ),
                        Container(
                          child: Text(
                            name, style: TextStyle(fontSize: 23, color: Color(0xffccc8d8))
                          ),
                          margin: EdgeInsets.only(left: 10, top: 20),
                        ),
                        Container(
                          child: Text(
                            (percent<0 ? '-$percent%' : '+$percent%'), style: TextStyle(fontSize: 22, color: Color(0xffccc8d8))
                          ),
                          width: 80,
                          margin: EdgeInsets.only(left: 98, top: 23),
                        ),
                        Container(
                          child: Container(
                            child: Image.asset( percent<0 ? 'assets/images/ArrowDown.png': 'assets/images/ArrowUp.png'),
                            width: 1,
                            height: 20,
                          ),
                          width: 20,
                          margin: EdgeInsets.only(left:0, top: 23),
                        )
                      ],
                      
                    ),
                    Container(
                      child: BigLineChart(),
                      height: 230,
                      margin: EdgeInsets.only(top: 80),
                    ),
                    Container(
                          child: Text('191,15€', style: TextStyle(fontSize: 37, color: Color(0xfff7f7f7))),
                          margin: EdgeInsets.only(left: 40, top: 65),
                        ),
                    Container(
                      child: Row(
                        children: [
                          MaterialButton(onPressed: (){
                          }, child: Text('1W', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF)),
                          MaterialButton(onPressed: (){
                          }, child: Text('1M', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF)),
                          MaterialButton(onPressed: (){
                          }, child: Text('3M', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF)),
                          MaterialButton(onPressed: (){
                          }, child: Text('1Y', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF)),
                          MaterialButton(onPressed: (){
                          }, child: Text('all', style: TextStyle(color: Color(0xfff7f7f7))), color: Color(0xff7245F7), height: 30, minWidth: 35, hoverColor: Color(0xff825FFF)),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      width: 320,
                      margin: EdgeInsets.only(top: 250, left: 45),
                      
                    ),
                    ])
                  
                  ,decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                    ),
                    color: Color(0xff6E28F9)),
                  
                    
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
            Container(child: Text("Summary")),
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
