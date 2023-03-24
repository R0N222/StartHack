import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<dynamic> getData(String symbol) async {
    String baseUrl =
      'https://www.alphavantage.co/query?function=OVERVIEW&symbol=Tesla&apikey=IFJ9ZCKKVYJQAKTB';
    var response = await http.get(Uri.parse(baseUrl));
    print(response);

    if (response.statusCode == 200) {
      
      var data1 = json.decode(response.body);
      var data2 = data1['EPS'];
      var data3 = data2;
      
      return data3;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
