import 'package:flutter/material.dart';
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
