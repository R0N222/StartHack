import 'package:http/http.dart' as http;

Future<http.Response> fetchStockLogo(String domain) {
  return http.get(Uri.parse('https://logo.clearbit.com/' + domain));
}
