import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:shoplanner/layers/domain/errors/price_excepition.dart';

abstract class PricesDataSource {
  AsyncResult<PriceEntity, PriceException> create(PriceEntity priceEntity);
  AsyncResult<PriceEntity, PriceException> update(double value);
  AsyncResult<bool, PriceException> delete(String id);
  AsyncResult<List<PriceEntity>, PriceException> fetchAll(String itemId);
}
