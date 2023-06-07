import 'package:shoplanner/layers/domain/errors/item_exception.dart';

class ItemUseCaseError extends ItemException {
  ItemUseCaseError(super.message);

  @override
  String toString() {
    return 'ItemUseCaseError: $message';
  }
}
