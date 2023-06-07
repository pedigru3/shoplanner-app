import 'package:flutter_test/flutter_test.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_users_datasource.dart';
import 'package:shoplanner/layers/data/repositories/user_repository_imp.dart';
import 'package:shoplanner/layers/domain/usecases/users_usecase/user_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/users_usecase/user_usecase_imp.dart';

void main() {
  test('Não permitir adicionar novo usuário', () async {
    UserUseCase userUsecase =
        UserUseCaseImp(UserRepositoryImp(UsersDataSourceMemory()));
    var result = await userUsecase.create('Felipe');
    var users = await userUsecase.fetchAll();
    expect(result.isError(), true);
    expect(users.getOrNull()!.length, 2);
  });

  test('Adiciona usuário Maira', () async {
    UserUseCase userUsecase =
        UserUseCaseImp(UserRepositoryImp(UsersDataSourceMemory()));
    var result = await userUsecase.create('Maira');
    var users = await userUsecase.fetchAll();
    expect(result.isError(), false);
    expect(result.isSuccess(), true);
    expect(users.getOrNull()!.length, 3);
  });
}
