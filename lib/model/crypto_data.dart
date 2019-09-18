class Crypto {
  final String name;
  final String priceUSD;
  final String percentChange1H;
  Crypto({this.name, this.priceUSD, this.percentChange1H});
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
