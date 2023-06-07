import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_items_datasource.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_prices_datasource.dart';
import 'package:shoplanner/layers/data/repositories/item_repository_imp.dart';
import 'package:shoplanner/layers/domain/errors/item_exception.dart';
import 'package:shoplanner/layers/domain/usecases/items_usecase/items_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/items_usecase/items_usecase_imp.dart';

void main() {
  test('shold not be able create a same item', () async {
    ItemsUseCase itemsUseCase = ItemsUseCaseImp(
      ItemRepositoryImp(
        itemsDataSource: ItemsDataSourceMemory(),
        pricesDataSource: PriceDataSourceMemory(),
      ),
    );

    await itemsUseCase
        .create(name: 'Macarrão', category: Category.Alimentos, prices: []);

    var result = await itemsUseCase
        .create(name: 'Macarrão', category: Category.Alimentos, prices: []);

    result.fold((success) {
      expect(success, null);
    }, (failure) {
      print(failure);
      expect(failure, isInstanceOf<ItemException>());
    });
  });
}
