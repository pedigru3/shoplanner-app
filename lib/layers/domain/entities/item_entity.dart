import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';

class ItemEntity extends Entity {
  ItemEntity({
    super.id,
    super.createdAt,
    required String name,
    required this.category,
    this.pricesEntity,
  }) {
    this.name = name;
    pricesEntity ??= [];
  }

  Category category;

  late String _name;
  List<PriceEntity>? pricesEntity;

  String get name => _name.capitalize();
  set name(String name) => _name = name.toUpperCase();

  set setPrice(double value) {
    final newPrice = PriceEntity(value: value);
    pricesEntity!.add(newPrice);
  }

  comparePrices() {
    if (pricesEntity == null) {
      return '';
    } else if (pricesEntity != null && pricesEntity!.length >= 2) {
      final diff = pricesEntity![pricesEntity!.length - 1].value -
          pricesEntity![pricesEntity!.length - 2].value;
      if (diff > 0) {
        return 'Este item está R\$ ${diff.toStringAsFixed(2)} mais caro';
      } else if (diff < 0) {
        return 'Este item está R\$ ${(-diff).toStringAsFixed(2)} mais barato';
      } else {
        return 'Este item manteve o último preço';
      }
    } else {
      return 'Item novo adicionado';
    }
  }
}

extension StringExtension on String {
  // criando uma extensão para a classe String
  String capitalize() {
    // adicionando o método capitalize() à extensão
    if (isEmpty) {
      return this; // retorna a string original se for vazia
    }
    return substring(0, 1).toUpperCase() +
        substring(1)
            .toLowerCase(); // retorna a string com a primeira letra maiúscula e o resto minúsculo
  }
}
