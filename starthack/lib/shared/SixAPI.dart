import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final client = HttpClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web API Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Web API Example'),
        ),
        body: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: fetchData(client),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Response: ${snapshot.data}');
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchStockByName(HttpClient client, String query) async {
  var url = Uri.parse('https://web.api.six-group.com/api/findata/v1/searchInstruments?query=${query}&size=1');
  var certificate = await rootBundle.load('lib/assets/certificate.p12').then((value) => value.buffer.asUint8List());
  var privateKey = await rootBundle.load('lib/assets/signed-certificate.pem').then((value) => value.buffer.asUint8List());
  var context = SecurityContext.defaultContext;
  context.useCertificateChainBytes(privateKey, password: 'hackaton2023');
  context.usePrivateKeyBytes(certificate, password: 'hackaton2023');
  var request = await client.getUrl(url);
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('api-version', '2022-01-01');
  var response = await request.close();
  if (response.statusCode == 200) {
    var responseBody = await response.transform(utf8.decoder).join();
    var jsdecoded = jsonDecode(responseBody);
    String shareShortName = jsdecoded['data']['searchInstruments'][0]['hit']['mostLiquidListing']['ticker'] + '_67';

    print('Response: $shareShortName');

    return fetchData2(client, shareShortName);
  } else {
    print(response.statusCode);
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> fetchData2(HttpClient client, String shareShortName) async {
  var url = Uri.parse('https://web.api.six-group.com/api/findata/v1/listings/marketData/eodTimeseries?scheme=TICKER_BC&from=2022-01-01&to=2022-01-31&ids=' + shareShortName);
  var certificate = await rootBundle.load('lib/assets/certificate.p12').then((value) => value.buffer.asUint8List());
  var privateKey = await rootBundle.load('lib/assets/signed-certificate.pem').then((value) => value.buffer.asUint8List());
  var context = SecurityContext.defaultContext;
  context.useCertificateChainBytes(privateKey, password: 'hackaton2023');
  context.usePrivateKeyBytes(certificate, password: 'hackaton2023');
  var request = await client.getUrl(url);
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('api-version', '2022-01-01');
  var response = await request.close();
  if (response.statusCode == 200) {
    var responseBody = await response.transform(utf8.decoder).join();
    var secondJsdecoded = jsonDecode(responseBody);

    print('Response: $secondJsdecoded');
    return secondJsdecoded;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load data');
  }
}

void AnalyzeData() {}
