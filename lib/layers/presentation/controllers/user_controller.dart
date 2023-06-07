import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:shoplanner/layers/domain/entities/validation/name_validation.dart';
import 'package:shoplanner/layers/domain/errors/user_controller_error.dart';
import 'package:shoplanner/layers/domain/errors/user_exception.dart';
import 'package:shoplanner/layers/domain/usecases/users_usecase/user_usecase.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';

import '../../domain/entities/validation/validation.dart';

class UserController extends ChangeNotifier {
  final UserUseCase userUseCase;
  UserController(this.userUseCase);

  Result<UserEntity, UserException>? currentUser;

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Validation nameValidation = NameValidation();

  setUser(UserEntity user) {
    AuthController.setUser(user);
    currentUser = Success(user);
    notifyListeners();
  }

  AsyncResult<UserEntity, UserException> createUser(String name) async {
    if (name.length < 3) {
      currentUser = Failure(UserControllerError('Nome inválido'));
    }
    final user = await userUseCase.create(name);

    return user.fold((success) {
      setUser(success);
      return currentUser!;
    }, (failure) {
      currentUser = Failure(failure);
      notifyListeners();
      return currentUser!;
    });
  }

  AsyncResult<List<UserEntity>, UserException> fetchAll() async {
    final users = await userUseCase.fetchAll();
    users.fold((success) {
      return Success(success);
    }, (failure) {
      return Failure(failure);
    });
    return users;
  }
}
