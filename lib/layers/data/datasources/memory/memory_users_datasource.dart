import 'package:shoplanner/layers/data/datasources/users_datasource.dart';
import 'package:shoplanner/layers/data/dtos/user_dto.dart';

class MemoryUsersDataSource implements UsersDataSource {
  final List<UserDto> _users = [
    UserDto(name: 'Felipe'),
    UserDto(name: 'Niège')
  ];

  @override
  Future<bool> create(UserDto user) async {
    _users.add(user);
    return true;
  }

  @override
  Future<bool> delete(UserDto user) async {
    _users.remove(user);
    return true;
  }

  @override
  Future<List<UserDto>> fetchAll() async {
    return _users;
  }

  @override
  Future<bool> update(UserDto user) {
    var index = _users.indexOf(user);
    _users[index] = user;
    return Future.value(true);
  }
}
