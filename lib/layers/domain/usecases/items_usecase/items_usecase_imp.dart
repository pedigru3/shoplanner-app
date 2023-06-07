import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:shoplanner/layers/domain/errors/item_exception.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/repositories/items_repository.dart';
import 'package:shoplanner/layers/domain/repositories/price_repository.dart';
import 'package:shoplanner/layers/domain/usecases/items_usecase/items_usecase.dart';

class ItemsUseCaseImp implements ItemsUseCase {
  final ItemsRepository itemsRepository;
  final PriceRepository pricesRepository;
  ItemsUseCaseImp(this.itemsRepository, this.pricesRepository);

  @override
  AsyncResult<ItemEntity, ItemException> create(
      {required String name,
      required Category category,
      required List<PriceEntity> prices}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  AsyncResult<bool, ItemException> delete(String id) {
    return itemsRepository.delete(id);
  }

  @override
  AsyncResult<List<ItemEntity>, ItemException> fetchAll() {
    return itemsRepository.fetchAll();
  }

  @override
  AsyncResult<ItemEntity, ItemException> update(
      {required String id, String? name, Category? category}) {
    return itemsRepository.update(id: id, name: name, category: category);
  }
}
