import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:shoplanner/layers/domain/errors/user_exception.dart';

abstract class UserUseCase {
  Future<Result<List<UserEntity>, UserException>> fetchAll();
  Future<Result<UserEntity, UserException>> create(String name);
  Future<bool> update(UserEntity user);
  Future<bool> delete(UserEntity user);
}
