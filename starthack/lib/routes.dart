import 'package:starthack/Homescreen/Homescreen.dart';
import 'package:starthack/Stock/Stockpage.dart';
import 'package:starthack/Homescreen/Homepage/UI/home_page.dart';
import 'package:starthack/Stock/Chart.dart';

var appRoutes = {
  '/': (context) => const HomePage(title: "Home"),
  '/stock': (context) => const StockScreenWidget(),
};
