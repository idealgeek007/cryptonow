import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

var coinapi = 'https://rest.coinapi.io/v1/exchangerate';
const apikey = '1C030DCF-7911-46B7-BE8C-F2478402C55E';

class CoinData {
  final String fiat;
  String? data;
  List<String> responses = [];

  CoinData(this.fiat);
  Future<dynamic> getCoinData(String fiat) async {
    for (int i = 0; i < 3; i++) {
      var url = '$coinapi/${cryptoList[i]}/$fiat?apikey=$apikey';

      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = response.body;
        responses.add((data!));
      } else {
        print(response.statusCode);
      }
    }
    print(responses);
    return responses;
  }
}
