import 'package:shoplanner/layers/domain/entities/item_entity.dart';

abstract class GetItemsByNameUseCase {
  Future<ItemEntity> call(String name);
}
