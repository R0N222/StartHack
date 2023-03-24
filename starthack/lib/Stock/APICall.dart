import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starthack/shared/Data.dart';

class ApiService {

  static Future<dynamic> getData(String symbol) async {
    String short = '';
    switch(symbol) { 
      case  'Apple': { 
      short='aapl';
    } 
    break; 
    case  'Amazon': { 
      short='amzn';
    } 
    break; 
    case  'Microsoft': { 
      short='msft';
    } 
    break; 
    case  'Netflix': { 
      short='nflx';
    } 
    break; 
    case  'Intel': { 
      short='intc';
    } 
    break; 
    case  'Meta': { 
      short='meta';
    } 
    break; 
    case  'Pepsico': { 
      short='pep';
    } 
    break; 
    case  'Adobe': { 
      short='adbe';
    } 
    break; 
    case  'amd': { 
      short='amd';
    } 
    break; 
    case  'comcast': { 
      short='cmcsa';
    } 
    break; 
    case  'qualcomm': { 
      short='qcom';
    } 
    break; 
    case  'honeywell': { 
      short='hon';
    } 
    break; 
    case  'intuit': { 
      short='intu';
    } 
    break; 
    case  'Tesla': { 
      short='tsla';
    } 
    break; 

} 
    print(short);
    String baseUrl =
      'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$short&apikey=IFJ9ZCKKVYJQAKTB';
    var response = await http.get(Uri.parse(baseUrl));
    print(response);

    if (response.statusCode == 200) {
      
      var data1 = json.decode(response.body);
      var data2 = data1['EPS'];
      eps = double.parse(data2);
      var s = data1['Sector'];
      sector=s;
      
    } else {
      throw Exception('Failed to load data');
    }
  }
}
