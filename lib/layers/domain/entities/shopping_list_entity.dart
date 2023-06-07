import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';

class ShoppingListEntity extends Entity {
  ShoppingListEntity(
      {super.createdAt,
      super.id,
      required this.name,
      List<ShoppingListItemEntity>? shoppingListItems}) {
    this.shoppingListItems = shoppingListItems ?? [];
  }

  String name;
  late List<ShoppingListItemEntity> shoppingListItems;

  double getTotal() {
    if (shoppingListItems.isNotEmpty) {
      List<double> result = shoppingListItems.map((e) => e.total).toList();
      double soma = result.reduce((value, element) => value + element);
      return soma;
    } else {
      return 0;
    }
  }

  factory ShoppingListEntity.fromMap(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw ArgumentError('The "id" field is required.');
    }
    if (json['name'] == null) {
      throw ArgumentError('The "name" field is required.');
    }
    if (json['createdAt'] == null) {
      throw ArgumentError('The "createdAt" field is required.');
    }
    return ShoppingListEntity(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      shoppingListItems: (json['ShoppingListItem'] ?? [])
              .map<ShoppingListItemEntity>(
                  (item) => ShoppingListItemEntity.fromMap(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
