import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import './SixAPI.dart';

List<String> myWatchList = []; //["Alphabet", "Microsoft", "Tesla"];

String currentStock = "";
double glpercent=0.0;
double glprice=0.0;
Map<String, double> percentages=HashMap();
Map<String, double> prices=HashMap();
String sector = "";
double eps=0.0;

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

Future<List<FlSpot>> getFlSpot(String name) async {
  var cl = HttpClient();

  var map = await fetchStockByName(cl, name);

  List<double> fldouble = findAllCloseValues("${map['data']}");

  List<FlSpot> flspots = [];
  for (int i = 0; i < fldouble.length; i++) {
    flspots.add(FlSpot(i.toDouble(), fldouble[i]));
  }
  return flspots;
}

final RegExp _keyValueRegex = RegExp(r'(\w+)\s*:\s*([\w.]+|".+?"|\{[^}]*\}|\[[^\]]*\])');
final RegExp _stringQuoteRegex = RegExp(r'^"(.*)"$');

List<double> findAllCloseValues(String data) {
  final closeValueRegex = RegExp(r'close:\s*([\d.]+)');
  final closeValueMatches = closeValueRegex.allMatches(data);

  return closeValueMatches.map((match) => double.parse(match.group(1)!)).toList();
}

Map<String, dynamic>? parseCustomJson(String data) {
  final keyValuePairs = _keyValueRegex.allMatches(data);
  if (keyValuePairs.isEmpty) return null;

  final result = <String, dynamic>{};

  for (final match in keyValuePairs) {
    final key = match.group(1) ?? '';
    String valueString = match.group(2) ?? '';
    dynamic value;

    if (valueString.startsWith('{')) {
      value = parseCustomJson(valueString);
    } else if (valueString.startsWith('[')) {
      value = valueString.substring(1, valueString.length - 1).split(',').map((str) => parseCustomJson(str.trim())).toList();
    } else {
      value = _stringQuoteRegex.hasMatch(valueString) ? valueString.substring(1, valueString.length - 1) : num.tryParse(valueString) ?? valueString;
    }

    result[key] = value;
  }

  return result;
}

List<FlSpot> extractFlSpots(String data) {
  List<FlSpot> flSpots = [];

  final parsedJson = parseCustomJson(data);
  if (parsedJson == null) return flSpots;

  final listings = parsedJson['listings'] as List<dynamic>?;
  if (listings == null || listings.isEmpty) return flSpots;

  final marketData = listings[0]['marketData'] as Map<String, dynamic>?;
  if (marketData == null) return flSpots;

  final timeseries = marketData['eodTimeseries'] as List<dynamic>?;
  if (timeseries == null) return flSpots;

  for (int i = 0; i < timeseries.length; i++) {
    if (timeseries[i].containsKey('close')) {
      DateTime date = DateTime.parse(timeseries[i]['sessionDate']);
      double closeValue = timeseries[i]['close'];
      flSpots.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), closeValue));
    }
  }

  return flSpots;
}

String preprocessData(String data) {
  return data.splitMapJoin(
    RegExp(r'\b\w+\b'),
    onMatch: (match) => '"${match.group(0)}"',
    onNonMatch: (nonMatch) => nonMatch,
  );
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
    print("Print Map: $map");
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
  List<FlSpot> getFlSpot() {
    List<FlSpot> flSpotList = [];

    for (var item in eodTimeseries) {
      // Check if all required values are present in the current item
      if (item.open != null && item.close != null) {
        FlSpot flSpot = FlSpot(
          DateTime.parse(item.sessionDate).millisecondsSinceEpoch.toDouble(),
          (item.open! + item.close!) / 2,
        );
        flSpotList.add(flSpot);
      }
    }

    return flSpotList;
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

List<Listing> jsonToListings(String jsonData) {
  List<Listing> listings = [];

  List<dynamic> jsonList = json.decode(jsonData)['data']['listings'];

  for (var jsonItem in jsonList) {
    Listing listing = Listing.fromMap(jsonItem);
    listings.add(listing);
  }
  return listings;
}
