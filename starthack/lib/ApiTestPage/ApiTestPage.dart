// button_page.dart
import 'package:flutter/material.dart';

import '../shared/SixAPICalls.dart';

class ApiTestPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ApiTestPage> {
  String displayedText = '';

  Future<String> getTextFromFunction() async {
    // Add 'await' here to properly wait for the response
    dynamic response = await SixAPIFetch.endOfDayPriceDataSixFetch(
        'AAPL_67', '2021-01-01', '2021-01-02');
    print(response);
    return response.toString();
  }

  void onButtonPressed() async {
    String result = await getTextFromFunction();
    setState(() {
      displayedText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onButtonPressed,
              child: Text('Press me'),
            ),
            SizedBox(height: 20), // Add some space between the button and text
            Text(displayedText),
          ],
        ),
      ),
    );
  }
}
