import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';

void main() {
  final shoppingListItem = ShoppingListItemEntity(
      itemEntity: ItemEntity(name: 'ARROz', category: Category.Alimentos),
      quantity: 2,
      currentPrice: 20);
  test('Nome do item deve ser colocado corretamente', () {
    expect(shoppingListItem.itemEntity.name, 'Arroz');
  });

  test('Deve retornar o total', (() {
    expect(shoppingListItem.total, 40);
  }));
}
