import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class SixAPIFetch {
  static dynamic endOfDayPriceDataSixFetch(
      String id, String timeFrom, String timeTo) async {
    final client = HttpClient();
    var url = Uri.parse(
        'https://web.api.six-group.com/api/findata/v1/listings/marketData/eodTimeseries?scheme=TICKER_BC&ids=' +
            id +
            '&from=' +
            timeFrom +
            '&to=' +
            timeTo);
    print(id);
    var certificate = await rootBundle
        .load('lib/shared/assets/certificate.p12')
        .then((value) => value.buffer.asUint8List());
    var privateKey = await rootBundle
        .load('lib/shared/assets/signed-certificate.pem')
        .then((value) => value.buffer.asUint8List());
    var context = SecurityContext.defaultContext;
    context.useCertificateChainBytes(privateKey, password: 'hackaton2023');
    context.usePrivateKeyBytes(certificate, password: 'hackaton2023');
    var request = await client.getUrl(url);
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('api-version', '2022-01-01');
    var response = await request.close();
    print("test");
    if (response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();

      print('Response: $responseBody');
      return responseBody;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }
}
