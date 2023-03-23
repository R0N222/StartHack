import 'package:starthack/Homescreen/Homescreen.dart';
import 'package:starthack/Stock/Stockpage.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/main.dart';

var appRoutes = {
  '/': (context) => const HomeScreenWidget(),
  '/stock': (context) => const SmallChartWidget(),
};
