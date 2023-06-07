import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';

class ShoppingListItemEntity extends Entity {
  ShoppingListItemEntity(
      {super.createdAt,
      super.id,
      required this.item,
      required this.quantity,
      required this.currentPrice});

  late ItemEntity item;
  PriceEntity currentPrice;
  double quantity;

  double get total => currentPrice.value * quantity;

  factory ShoppingListItemEntity.fromMap(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception("The 'id' field is missing in the JSON.");
    }
    if (json['item'] == null) {
      throw Exception("The 'item' field is missing in the JSON.");
    }
    if (json['quantity'] == null) {
      throw Exception("The 'quantity' field is missing in the JSON.");
    }
    if (json['currentPrice'] == null) {
      throw Exception("The 'currentPrice' field is missing in the JSON.");
    }
    if (json['createdAt'] == null) {
      throw Exception("The 'createdAt' field is missing in the JSON.");
    }

    return ShoppingListItemEntity(
      id: json['id'],
      item: ItemEntity.fromMap(json['item']),
      quantity: double.parse(json['quantity']),
      currentPrice: PriceEntity.fromMap(json['currentPrice']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'quantity': quantity,
      'currentPrice': currentPrice,
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
