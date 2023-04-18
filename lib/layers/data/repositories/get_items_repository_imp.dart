import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/dtos/item_dto.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/repositories/get_items_repository.dart';

class GetItemsRepositoryImp implements GetItemsRepository {
  
  @override
  Future<ItemEntity> byId(String id) async {
    if (id == '1') {
      return ItemDto(name: 'Macarrão', category: Category.Alimentos, id: '1');
    } else {
      throw Exception('Não encontrado');
    }
  }

  @override
  Future<ItemEntity> byName(String name) async {
    return ItemDto(name: 'Macarrão', category: Category.Alimentos);
  }
}
