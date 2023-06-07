import 'package:shoplanner/layers/domain/errors/price_excepition.dart';

class PriceUseCaseError extends PriceException {
  PriceUseCaseError(super.message);

  @override
  String toString() => 'PriceUseCaseError: $message';
}
