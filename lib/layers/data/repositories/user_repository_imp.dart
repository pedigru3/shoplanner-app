import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/users_datasource.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:shoplanner/layers/domain/errors/user_exception.dart';
import 'package:shoplanner/layers/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UsersDataSource userData;
  UserRepositoryImp(this.userData);

  @override
  AsyncResult<UserEntity, UserException> create(String name) async {
    UserEntity user = UserEntity(name: name);
    return await userData.create(user);
  }

  @override
  Future<bool> delete(UserEntity user) {
    return userData.delete(user);
  }

  @override
  Future<bool> update(UserEntity user) {
    return userData.update(user);
  }

  @override
  AsyncResult<List<UserEntity>, UserException> fetchAll() {
    return userData.fetchAll();
  }
}
