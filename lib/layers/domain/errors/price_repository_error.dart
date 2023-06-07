import 'package:shoplanner/layers/domain/errors/price_excepition.dart';

class PriceRepositoryError extends PriceException {
  PriceRepositoryError(super.message);

  @override
  String toString() => 'PriceRepositoryError: $message';
}
