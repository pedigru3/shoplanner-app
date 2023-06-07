import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/datasources/items_datasource.dart';
import 'package:shoplanner/layers/domain/errors/item_already_exists_exception.dart';
import 'package:shoplanner/layers/domain/errors/item_datasorce_error.dart';
import 'package:shoplanner/layers/domain/errors/item_exception.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';

class ItemsDataSourceMemory implements ItemsDataSource {
  final List<ItemEntity> _items = [];

  @override
  AsyncResult<ItemEntity, ItemException> create(
      {required String name,
      required Category category,
      required prices}) async {
    try {
      var newItem = ItemEntity(name: name, category: category, prices: prices);
      _items.add(newItem);
      return Success(newItem);
    } catch (e) {
      return Failure(ItemDataSourceError('Error creating item: $e'));
    }
  }

  @override
  AsyncResult<bool, ItemException> delete(String id) async {
    // delete item in list
    try {
      _items.removeWhere((item) => item.id == id);
      return const Success(true);
    } catch (e) {
      return Failure(ItemDataSourceError('Error deleting item: $e'));
    }
  }

  @override
  AsyncResult<List<ItemEntity>, ItemException> fetchAll() async {
    return Success(_items);
  }

  @override
  AsyncResult<ItemEntity, ItemException> update(
      {required String id, String? name, Category? category}) async {
    try {
      var item = _items.firstWhere((item) => item.id == id);
      if (name != null) {
        item.name = name;
      }
      if (category != null) {
        item.category = category;
      }
      _items[_items.indexOf(item)] = item;
      return Success(item);
    } catch (e) {
      return Failure(ItemDataSourceError('Error updating item: $e'));
    }
  }

  @override
  AsyncResult<ItemEntity, ItemException> fetchbyName(String name) async {
    try {
      var item = _items.firstWhere((item) => item.name == name);
      return Success(item);
    } catch (e) {
      return Failure(ItemAlreadyExistsException('Error fetching item: $e'));
    }
  }
}
