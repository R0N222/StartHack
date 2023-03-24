import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

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

class Listing {
  String requestedId;
  String requestedScheme;
  String lookupStatus;
  Lookup lookup;
  MarketData marketData;

  Listing({
    required this.requestedId,
    required this.requestedScheme,
    required this.lookupStatus,
    required this.lookup,
    required this.marketData,
  });

  factory Listing.fromMap(Map<String, dynamic> map) {
    return Listing(
      requestedId: map['requestedId'],
      requestedScheme: map['requestedScheme'],
      lookupStatus: map['lookupStatus'],
      lookup: Lookup.fromMap(map['lookup']),
      marketData: MarketData.fromMap(map['marketData']),
    );
  }
}

class Lookup {
  String listingName;
  String marketName;
  String listingCurrency;
  String listingStatus;

  Lookup({
    required this.listingName,
    required this.marketName,
    required this.listingCurrency,
    required this.listingStatus,
  });

  factory Lookup.fromMap(Map<String, dynamic> map) {
    return Lookup(
      listingName: map['listingName'],
      marketName: map['marketName'],
      listingCurrency: map['listingCurrency'],
      listingStatus: map['listingStatus'],
    );
  }
}

class MarketData {
  List<EodTimeSeries> eodTimeseries;

  MarketData({
    required this.eodTimeseries,
  });

  factory MarketData.fromMap(Map<String, dynamic> map) {
    List<EodTimeSeries> eodTimeseriesList = [];
    for (var item in map['eodTimeseries']) {
      eodTimeseriesList.add(EodTimeSeries.fromMap(item));
    }
    return MarketData(eodTimeseries: eodTimeseriesList);
  }
}

class EodTimeSeries {
  String sessionDate;
  double? open;
  double? close;
  double? low;
  double? high;
  int? volume;

  EodTimeSeries({
    required this.sessionDate,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  factory EodTimeSeries.fromMap(Map<String, dynamic> map) {
    return EodTimeSeries(
      sessionDate: map['sessionDate'],
      open: map['open'],
      close: map['close'],
      low: map['low'],
      high: map['high'],
      volume: map['volume'],
    );
  }
}

List<Listing> jsonToListings() {
  List<Listing> listings = [];

  String jsonData = '{...}'; // JSON data goes here

  List<dynamic> jsonList = json.decode(jsonData)['data']['listings'];

  for (var jsonItem in jsonList) {
    Listing listing = Listing.fromMap(jsonItem);
    listings.add(listing);
  }
  return listings;
}
