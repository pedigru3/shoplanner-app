import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:shoplanner/layers/domain/errors/user_usecase_error.dart';
import 'package:shoplanner/layers/domain/errors/user_exception.dart';
import 'package:shoplanner/layers/domain/repositories/shopping_list_repository.dart';
import 'package:shoplanner/layers/domain/usecases/users_usecase/user_usecase.dart';
import '../../repositories/user_repository.dart';

class UserUseCaseImp implements UserUseCase {
  final UserRepository userRepository;
  final ShoppingListRepository shoppingListRepository;
  UserUseCaseImp(this.userRepository, this.shoppingListRepository);

  @override
  AsyncResult<UserEntity, UserException> create(String name) async {
    final users = await userRepository.fetchAll();
    final names = users.map((success) => success.map((e) => e.name).toList());

    return names.fold((names) async {
      if (names.contains(name)) {
        return Failure(UserUseCaseError('Nome do usuário já existe'));
      } else {
        try {
          var user = await userRepository.create(name).getOrThrow();
          await shoppingListRepository.create(name);
          return Success(user);
        } catch (e) {
          return Failure(UserUseCaseError('Erro ao criar usuário: $e'));
        }
      }
    }, (failure) {
      return Failure(failure);
    });
  }

  @override
  Future<bool> delete(UserEntity user) {
    return userRepository.delete(user);
  }

  @override
  Future<bool> update(UserEntity user) {
    return userRepository.update(user);
  }

  @override
  Future<Result<List<UserEntity>, UserException>> fetchAll() {
    return userRepository.fetchAll();
  }
}
