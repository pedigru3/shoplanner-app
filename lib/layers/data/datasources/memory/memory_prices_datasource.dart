import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/prices_datasource.dart';
import 'package:shoplanner/layers/domain/errors/price_datasource_error.dart';
import 'package:shoplanner/layers/domain/errors/price_excepition.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';

class PriceDataSourceMemory implements PricesDataSource {
  final List<PriceEntity> _prices = [];

  @override
  AsyncResult<PriceEntity, PriceException> create(
      PriceEntity priceEntity) async {
    try {
      _prices.add(priceEntity);
      return Success(priceEntity);
    } catch (e) {
      return Failure(PriceDataSourceError('Error creating price: $e'));
    }
  }

  @override
  AsyncResult<bool, PriceException> delete(String id) async {
    try {
      _prices.removeWhere((price) => price.id == id);
      return const Success(true);
    } catch (e) {
      return Failure(PriceDataSourceError('Error deleting price: $e'));
    }
  }

  @override
  AsyncResult<List<PriceEntity>, PriceException> fetchAll(String itemId) async {
    return Success(_prices);
  }

  @override
  AsyncResult<PriceEntity, PriceException> update(double value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
