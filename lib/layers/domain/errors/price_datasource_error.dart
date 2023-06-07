import 'package:shoplanner/layers/domain/errors/price_excepition.dart';

class PriceDataSourceError extends PriceException {
  PriceDataSourceError(super.message);

  @override
  String toString() {
    return 'PriceDataSourceError: $message';
  }
}
