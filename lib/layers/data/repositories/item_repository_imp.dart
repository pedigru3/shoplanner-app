import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/items_datasource.dart';
import 'package:shoplanner/layers/data/datasources/prices_datasource.dart';
import 'package:shoplanner/layers/domain/errors/item_exception.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/repositories/items_repository.dart';

class ItemRepositoryImp implements ItemsRepository {
  final ItemsDataSource itemsDataSource;
  final PricesDataSource pricesDataSource;
  ItemRepositoryImp({
    required this.itemsDataSource,
    required this.pricesDataSource,
  });

  @override
  AsyncResult<ItemEntity, ItemException> create(
      {required String name,
      required Category category,
      required List<PriceEntity> prices}) async {
    return itemsDataSource.create(
        name: name, category: category, prices: prices);
  }

  @override
  AsyncResult<bool, ItemException> delete(String id) {
    return itemsDataSource.delete(id);
  }

  @override
  AsyncResult<List<ItemEntity>, ItemException> fetchAll() {
    return itemsDataSource.fetchAll();
  }

  @override
  AsyncResult<ItemEntity, ItemException> update(
      {required String id, String? name, Category? category}) {
    return itemsDataSource.update(id: id, name: name, category: category);
  }

  @override
  AsyncResult<ItemEntity, ItemException> fetchbyName(String name) {
    return itemsDataSource.fetchbyName(name);
  }
}
