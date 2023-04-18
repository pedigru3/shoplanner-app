import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/layers/data/repositories/get_items_repository_imp.dart';
import 'package:shoplanner/layers/domain/usecases/get_items_by_name/get_items_by_name.dart';
import 'package:shoplanner/layers/domain/usecases/get_items_by_name/get_items_by_name_imp.dart';

main() {
  test('shold be return item Macarrão', () async {
    GetItemsByNameUseCase getItems = GetItemsByNameUseCaseImpl(
      GetItemsRepositoryImp(),
    );

    var result = await getItems('Queijo');

    expect(result.name, 'Queijo');
  });
}
