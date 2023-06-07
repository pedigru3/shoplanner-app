import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:shoplanner/layers/domain/errors/item_exception.dart';

abstract class ItemsUseCase {
  AsyncResult<ItemEntity, ItemException> create({
    required String name,
    required Category category,
    required List<PriceEntity> prices,
  });
  AsyncResult<ItemEntity, ItemException> update(
      {required String id, String? name, Category? category});
  AsyncResult<bool, ItemException> delete(String id);
  AsyncResult<List<ItemEntity>, ItemException> fetchAll();
}
