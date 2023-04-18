import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';

void main() {
  test('deve retornar nome do supermercado', () {
    ShoppingListEntity shop = ShoppingListEntity(marketName: 'Mufato');
    expect(shop.marketName, 'Mufato');
  });
}
