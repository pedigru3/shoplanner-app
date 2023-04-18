import 'package:shoplanner/layers/domain/entities/item_entity.dart';

abstract class GetItemsRepository {
  Future<ItemEntity> byName(String name);
  Future<ItemEntity> byId(String id);
}
