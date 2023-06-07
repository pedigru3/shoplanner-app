import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';

class ItemEntity extends Entity {
  ItemEntity({
    super.id,
    super.createdAt,
    required String name,
    required this.category,
    required this.prices,
  }) {
    this.name = name;
  }

  factory ItemEntity.fromMap(Map<String, dynamic> json) {
    if (json['prices'] == null) {}
    return ItemEntity(
      id: json['id'],
      name: json['name'],
      category: categoryFromString(json['category']),
      createdAt: DateTime.parse(json['createdAt']),
      prices: json['prices'] != null
          ? json['prices']
              .map<PriceEntity>((price) => PriceEntity.fromMap(price))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'prices': prices.map((price) => price.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'id': id,
    };
  }

  Category category;

  late String _name;
  List<PriceEntity> prices;

  String get name => _name.capitalize();
  set name(String name) => _name = name.toUpperCase();

  //get last price in pricesEntity
  double get lastPrice {
    if (prices.isEmpty) {
      return 0;
    } else {
      return prices.last.value;
    }
  }

  comparePrices() {
    if (prices.length >= 2) {
      final diff =
          prices[prices.length - 1].value - prices[prices.length - 2].value;
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
