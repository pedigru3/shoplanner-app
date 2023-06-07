import 'package:dson_adapter/dson_adapter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/database/db.dart';
import 'package:shoplanner/layers/data/datasources/prices_datasource.dart';
import 'package:shoplanner/layers/domain/errors/price_datasource_error.dart';
import 'package:shoplanner/layers/domain/errors/price_excepition.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:sqflite/sqflite.dart';

class PricesDataSourceLocal implements PricesDataSource {
  late Database db;
  final dson = const DSON();

  @override
  AsyncResult<PriceEntity, PriceException> create(
      PriceEntity priceEntity) async {
    db = await DB.instance.database;
    try {
      //verifica se o insert foi feito com sucesso
      var result = await db.insert('prices', priceEntity.toMap());
      if (result == 0) {
        return Failure(PriceDataSourceError('Error creating price'));
      }
      return Success(priceEntity);
    } catch (e) {
      return Failure(PriceDataSourceError('Error creating price: $e'));
    }
  }

  @override
  AsyncResult<bool, PriceException> delete(String id) async {
    db = await DB.instance.database;

    try {
      var result = await db.delete('prices', where: 'id = ?', whereArgs: [id]);
      if (result == 0) {
        return Failure(PriceDataSourceError('Error deleting price'));
      }
      return const Success(true);
    } catch (e) {
      return Failure(PriceDataSourceError('Error deleting price: $e'));
    }
  }

  @override
  AsyncResult<List<PriceEntity>, PriceException> fetchAll(String itemId) async {
    db = await DB.instance.database;
    try {
      var result = await db.query(
        'prices',
        columns: ['id', 'value', 'item_id'],
        where: 'item_id = ?',
        whereArgs: [itemId],
      );

      var prices = dson.fromJson(result, PriceEntity.new) as List<PriceEntity>;
      return Success(prices);
    } catch (e) {
      return Failure(PriceDataSourceError('Error fetching prices: $e'));
    }
  }

  @override
  AsyncResult<PriceEntity, PriceException> update(double value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
