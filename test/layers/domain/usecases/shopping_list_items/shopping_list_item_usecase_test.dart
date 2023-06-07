import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_items_datasource.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_prices_datasource.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_shopping_list_items_datasource.dart';
import 'package:shoplanner/layers/data/repositories/item_repository_imp.dart';
import 'package:shoplanner/layers/data/repositories/price_repository_imp.dart';
import 'package:shoplanner/layers/data/repositories/shopping_list_item_repository_imp.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase_imp.dart';

void main() {
  final ItemsDataSourceMemory itemsDataSourceMemory = ItemsDataSourceMemory();
  final ShoppingListItemUseCase shoppingListItemUsecase =
      ShoppingListItemUseCaseImp(
          ShoppingListItemRepositoryImp(
            ShoppingListItemsDataSourceMemory(),
          ),
          ItemRepositoryImp(
            itemsDataSource: itemsDataSourceMemory,
            pricesDataSource: PriceDataSourceMemory(),
          ),
          PriceRepositoryImp(PriceDataSourceMemory()));

  test('Deve criar dois itens', () async {
    final result = await shoppingListItemUsecase.create(
        'Cereal', 2, 3.2, Category.Alimentos);

    result.fold(
      (success) {
        expect(success.item.name, 'Cereal');
        expect(success.quantity, 2);
        expect(success.currentPrice, 3.2);
        expect(success.item.category, Category.Alimentos);
      },
      (failure) => expect(failure, null),
    );
  });

  test('Deve retornar uma lista de items', () async {
    final result = await shoppingListItemUsecase.fetchAll();
    result.fold(
      (success) {
        expect(success.length, 1);
      },
      (failure) => expect(failure, null),
    );
    expect(result.isSuccess(), true);
  });

  test('Não deve criar um item com mesmo nome', () async {
    final result = await shoppingListItemUsecase.create(
        'Cereal', 2, 4.2, Category.Alimentos);

    final items = await itemsDataSourceMemory.fetchAll();

    items.fold(
      (success) {
        expect(success.length, 1);
        expect(success[0].name, 'Cereal');
      },
      (failure) => expect(failure, null),
    );

    result.fold(
      (success) {
        expect(success.item.name, 'Cereal');
        expect(success.quantity, 2);
        expect(success.currentPrice, 4.2);
        expect(
            success.item.comparePrices(), 'Este item está R\$ 1.00 mais caro');
        expect(success.item.category, Category.Alimentos);
      },
      (failure) => expect(failure, null),
    );
  });
}
