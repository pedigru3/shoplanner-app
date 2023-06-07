import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:shoplanner/layers/domain/errors/user_exception.dart';

abstract class UsersDataSource {
  AsyncResult<List<UserEntity>, UserException> fetchAll();
  AsyncResult<UserEntity, UserException> create(UserEntity user);
  Future<bool> update(UserEntity user);
  Future<bool> delete(UserEntity user);
}
