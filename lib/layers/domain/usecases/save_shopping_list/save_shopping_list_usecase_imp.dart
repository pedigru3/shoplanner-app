import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/repositories/save_shopping_list_repository.dart';
import 'package:shoplanner/layers/domain/usecases/save_shopping_list/save_shopping_list_usecase.dart';

class SaveShoppingListUseCaseImpl implements SaveShoppingListUseCase {
  final SaveShoppingListRepository _saveShoppingListRepository;
  SaveShoppingListUseCaseImpl(this._saveShoppingListRepository);

  @override
  Future<void> call(ShoppingListEntity shoppingListEntity) {
    if (shoppingListEntity.marketName != '') {
      throw Exception('É necessário um nome válido de supermercado');
    }
    if (shoppingListEntity.marketName.length < 3) {
      throw Exception('Nome do mercado é muito curto');
    }
    return _saveShoppingListRepository(shoppingListEntity);
  }
}
