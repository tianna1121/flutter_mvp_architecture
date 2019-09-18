class Crypto {
  final String name;
  final String priceUSD;
  final String percentChange1H;
  Crypto({this.name, this.priceUSD, this.percentChange1H});
  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        priceUSD = map['price_usd'],
        percentChange1H = map['percent_change_1h'];
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return 'Exception';
    return 'Exception: $_message';
  }
}
