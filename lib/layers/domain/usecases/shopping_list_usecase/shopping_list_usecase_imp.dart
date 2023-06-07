import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/repositories/shopping_list_repository.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';

class ShoppingListUseCaseImpl implements ShoppingListUseCase {
  final ShoppingListRepository _saveShoppingListRepository;
  ShoppingListUseCaseImpl(this._saveShoppingListRepository);

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> create(String name) {
    return _saveShoppingListRepository.create(name);
  }

  @override
  AsyncResult<bool, ShoppingListException> delete(String id) {
    return _saveShoppingListRepository.delete(id);
  }

  @override
  AsyncResult<List<ShoppingListEntity>, ShoppingListException> fetchAll() {
    return _saveShoppingListRepository.fetchAll();
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> update(
      String id, String name) {
    return _saveShoppingListRepository.update(id, name);
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> fetchById(String id) {
    return _saveShoppingListRepository.fetchById(id);
  }
}
