import 'package:shared_preferences/shared_preferences.dart';

var myWatchList = ["Alphabet", "Microsoft", "Tesla"];

String currentStock = "";

Future loadWatchList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  myWatchList = prefs.getStringList('watchlist') ?? [];
}

Future saveWatchList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('watchlist', myWatchList);
}
