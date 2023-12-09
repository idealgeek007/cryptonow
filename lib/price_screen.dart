import 'dart:convert';

import 'package:cryptonow/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

double? price;
String btcPrice = '';
String ltcPrice = '';
String ethPrice = '';
String? selectCurrency = 'INR';

List<String>? formattedValue;

class _PriceScreenState extends State<PriceScreen> {
  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItemns = [];

    for (int i = 0; i < currenciesList.length; i++) {
      String currency = (currenciesList[i]);
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItemns.add(newItem);
    }
    return dropDownItemns;
  }

  @override
  void initState() {
    super.initState();
  }

  void updateCur(String selectCurrency) async {
    var coindata = CoinData(selectCurrency!);
    print(coindata.responses);
    try {
      List data = await coindata.getCoinData(coindata.fiat);
      btcPrice = jsonDecode(data[0])['rate'].toStringAsFixed(2);
      ethPrice = jsonDecode(data[1])['rate'].toStringAsFixed(2);
      ltcPrice = jsonDecode(data[2])['rate'].toStringAsFixed(2);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        title: Text('CRYPTO-NOW'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                convDisp(cryptoList[0], btcPrice, selectCurrency!),
                convDisp(cryptoList[1], ethPrice, selectCurrency!),
                convDisp(cryptoList[2], ltcPrice, selectCurrency!),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: dropDownContainer(context),
          ),
        ],
      ),
    );
  }

  Container dropDownContainer(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 150.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 30.0),
      child: ButtonTheme(
        minWidth: 200.0,
        buttonColor: Colors.blue,
        child: DropdownButton<String>(
          menuMaxHeight: 300.0,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
          focusColor: Theme.of(context).colorScheme.primary,
          dropdownColor: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10.0),
          value: selectCurrency,
          items: getDropDownItems(),
          onChanged: (String? value) {
            setState(() {
              selectCurrency = value!;
            });
          },
        ),
      ),
    );
  }
}

class convDisp extends StatelessWidget {
  String fiatvalue;
  String crypto;
  String selectCurrency;
  convDisp(this.crypto, this.fiatvalue, this.selectCurrency, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '$crypto = $fiatvalue $selectCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
