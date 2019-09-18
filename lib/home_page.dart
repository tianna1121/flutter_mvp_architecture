import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _currencies;
  bool _isLoading = true;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    getCurrencies();
    super.initState();
  }

  void getCurrencies() async {
    String cryptoUrl = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
    http.Response response = await http.get(cryptoUrl);
    _currencies = json.decode(response.body);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto App'),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _isLoading == true ? CircularProgressIndicator() : _cryptoWidget(),
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(
        currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubTitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubTitleText(String priceUSD, String percentChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: '\$$priceUSD\n', style: TextStyle(color: Colors.black));
    String percentChangeText = '1 hour: $percentChange%';
    TextSpan percentChangeTextWidget;
    if (double.parse(percentChange) > 0) {
      percentChangeTextWidget = TextSpan(
          text: percentChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentChangeTextWidget = TextSpan(
          text: percentChangeText, style: TextStyle(color: Colors.red));
    }

    return RichText(
      text: TextSpan(children: [priceTextWidget, percentChangeTextWidget]),
    );
  }

  Widget _cryptoWidget() {
    return Container(
        child: Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final Map _currency = _currencies[index];
              final MaterialColor _color = _colors[index % _colors.length];
              return _getListItemUi(_currency, _color);
            },
            itemCount: _currencies.length,
          ),
        ),
      ],
    ));
  }
}
