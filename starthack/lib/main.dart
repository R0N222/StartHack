import 'package:flutter/material.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/routes.dart';

import 'package:starthack/Stock/Stockpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
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
        color: Colors.white,
      ),
    );
      
      
  }
}
