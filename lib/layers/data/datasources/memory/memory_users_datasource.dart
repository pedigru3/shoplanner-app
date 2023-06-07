import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/users_datasource.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:shoplanner/layers/domain/errors/user_datasource_error.dart';

class UsersDataSourceMemory implements UsersDataSource {
  final List<UserEntity> _users = [];

  @override
  AsyncResult<UserEntity, UserDataSourceError> create(UserEntity user) async {
    try {
      _users.add(user);
      return Success(user);
    } catch (e) {
      return Failure(UserDataSourceError('Error in create user: $e'));
    }
  }

  @override
  Future<bool> delete(UserEntity user) async {
    _users.remove(user);
    return true;
  }

  @override
  Future<bool> update(UserEntity user) {
    var index = _users.indexOf(user);
    _users[index] = user;
    return Future.value(true);
  }

  @override
  AsyncResult<List<UserEntity>, UserDataSourceError> fetchAll() async {
    try {
      return Success(_users);
    } catch (e) {
      return Failure(UserDataSourceError('Erro in fetchAll: $e'));
    }
  }
}
