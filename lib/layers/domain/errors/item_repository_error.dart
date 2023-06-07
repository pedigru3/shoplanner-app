import 'package:shoplanner/layers/domain/errors/item_exception.dart';

class ItemRepositoryError extends ItemException {
  ItemRepositoryError(super.message);

  @override
  String toString() {
    return 'ItemRepositoryError: $message';
  }
}
