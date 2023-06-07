import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/prices_datasource.dart';
import 'package:shoplanner/layers/domain/errors/price_excepition.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:shoplanner/layers/domain/repositories/price_repository.dart';

class PriceRepositoryImp implements PriceRepository {
  final PricesDataSource pricesDataSource;
  PriceRepositoryImp(this.pricesDataSource);

  @override
  AsyncResult<PriceEntity, PriceException> create(double value, String itemId) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<bool, PriceException> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<PriceEntity>, PriceException> fetchAll(String itemId) {
    return pricesDataSource.fetchAll(itemId);
  }

  @override
  AsyncResult<PriceEntity, PriceException> update(double value, String id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
