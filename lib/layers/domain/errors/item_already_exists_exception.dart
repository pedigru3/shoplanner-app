// create a class ItemAlreadyExistsException

import 'package:shoplanner/layers/domain/errors/item_exception.dart';

class ItemAlreadyExistsException extends ItemException {
  ItemAlreadyExistsException(super.message);

  @override
  String toString() {
    return 'ItemAlreadyExistsException: $message';
  }
}
