import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';

void main() {
  group('Deve comparar preços corretamente', () {
    test('quando o valor está mais caro', () {
      final item = ItemEntity(
          category: Category.Alimentos,
          name: 'Macarrão',
          pricesEntity: [PriceEntity(value: 2.2), PriceEntity(value: 3.1)]);
      expect(item.comparePrices(), 'Este item está R\$ 0.90 mais caro');
    });
    test('quando o valor está mais barato', () {
      final item = ItemEntity(
          category: Category.Alimentos,
          name: 'Macarrão',
          pricesEntity: [PriceEntity(value: 3.1), PriceEntity(value: 2.2)]);
      expect(item.comparePrices(), 'Este item está R\$ 0.90 mais barato');
    });
    test('quando o valor está igual', () {
      final item = ItemEntity(
          category: Category.Alimentos,
          name: 'Macarrão',
          pricesEntity: [PriceEntity(value: 3.1), PriceEntity(value: 3.1)]);
      expect(item.comparePrices(), 'Este item manteve o último preço');
    });
  });
}
