import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_prices_datasource.dart';
import 'package:shoplanner/layers/data/repositories/price_repository_imp.dart';
import 'package:shoplanner/layers/domain/errors/price_excepition.dart';
import 'package:shoplanner/layers/domain/errors/price_usecase_error.dart';

void main() {
  test('shold be return a price entity', () async {
    final PriceUse priceUseCase =
        PriceUseCase(PriceRepositoryImp(PriceDataSourceMemory()));
    var result = await priceUseCase.create(0);
    result.fold((success) {
      expect(success, null);
    }, (failure) {
      expect(failure, isInstanceOf<PriceException>());
    });
  });
}
