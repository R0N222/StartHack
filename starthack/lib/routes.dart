import 'package:starthack/Homescreen/Homescreen.dart';
import 'package:starthack/Stock/Stockpage.dart';
import 'package:starthack/Stock/Chart.dart';

var appRoutes = {
  '/': (context) => const HomeScreenWidget(),
  '/stock': (context) => const StockScreenWidget(),
};
