import 'package:flutter_mvp_architecture/model/crypto_data.dart';

// * dummy data for testing
class MockCryptoRepository implements CryptoRepository {
  @override
  Future<List<Crypto>> fetchCurrencies() {
    return Future.value(currencies);
  }
}

var currencies = <Crypto>[
  new Crypto(name: 'Bitcoin', priceUSD: '10000.00', percentChange1H: '-0.8'),
  new Crypto(name: 'Etherum', priceUSD: '200.00', percentChange1H: '0.85'),
  new Crypto(name: 'Ripple', priceUSD: '3.00', percentChange1H: '-0.24'),
];
