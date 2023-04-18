import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/repositories/get_items_repository.dart';
import 'package:shoplanner/layers/domain/usecases/get_items_by_name/get_items_by_name.dart';

class GetItemsByNameUseCaseImpl implements GetItemsByNameUseCase {
  final GetItemsRepository _getItemsRepository;
  GetItemsByNameUseCaseImpl(this._getItemsRepository);

  @override
  Future<ItemEntity> call(String name) async {
    if (name != '') {
      return _getItemsRepository.byName(name);
    } else {
      throw Exception('Erro ao buscar item pelo nome');
    }
  }
}
