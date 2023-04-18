import 'package:shoplanner/layers/data/dtos/user_dto.dart';

abstract class UsersDataSource {
  Future<List<UserDto>> fetchAll();
  Future<bool> create(UserDto user);
  Future<bool> update(UserDto user);
  Future<bool> delete(UserDto user);
}
