import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> myWatchList = []; //["Alphabet", "Microsoft", "Tesla"];

String currentStock = "";

Future loadWatchList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  myWatchList = prefs.getStringList('watchlist') ?? [];
}

void addToWatchList(String val) {
  myWatchList.add(val);
  saveWatchList();
}

void removeToWatchList(String val) {
  myWatchList.remove(val);
  saveWatchList();
}

bool isOnWatchlist(String value) {
  return myWatchList.contains(value);
}

Future saveWatchList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('watchlist', myWatchList);
}

List<FlSpot> getFlSpot() {
  return [];
}
