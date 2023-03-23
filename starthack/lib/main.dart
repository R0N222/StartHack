import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/routes.dart';
import 'package:starthack/shared/theme.dart';
import 'package:starthack/Stock/Stockpage.dart';
import 'package:starthack/shared/Data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadWatchList(),
        builder: (context, snapshot) {
          return MaterialApp(
            routes: appRoutes,
            theme: appTheme,
          );
        });
  }
}
