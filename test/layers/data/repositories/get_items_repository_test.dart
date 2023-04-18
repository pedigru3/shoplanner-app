import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/layers/data/repositories/get_items_repository_imp.dart';
import 'package:shoplanner/layers/domain/repositories/get_items_repository.dart';

void main() {
  GetItemsRepository getItemsRepository = GetItemsRepositoryImp();

  test('shold be return any item', () {
    var result = getItemsRepository.byName('qualquer');

    expect(result, isNotNull);
  });
}
