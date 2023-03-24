import 'package:starthack/Homescreen/Homescreen.dart';
import 'package:starthack/Stock/Stockpage.dart';
import 'package:starthack/Homescreen/Homepage/UI/home_page.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/main.dart';
import 'package:starthack/shared/Data.dart';

var appRoutes = {
  '/': (context) => const HomePage(title: "Home"),
  '/stock': (context) => StockScreenWidget(name: currentStock, percent: glpercent, price: glprice),
};
