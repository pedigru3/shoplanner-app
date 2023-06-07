import 'package:shoplanner/layers/domain/errors/item_exception.dart';

class ItemDataSourceError extends ItemException {
  ItemDataSourceError(super.message);

  @override
  String toString() {
    return 'ItemDataSourceError: $message';
  }
}
