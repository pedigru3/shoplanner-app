import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/data/datasources/items_datasource.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_items_datasource.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_prices_datasource.dart';
import 'package:shoplanner/layers/data/datasources/memory/memory_users_datasource.dart';
import 'package:shoplanner/layers/data/datasources/prices_datasource.dart';
import 'package:shoplanner/layers/data/datasources/remote/shopping_list_datasource_remote.dart';
import 'package:shoplanner/layers/data/datasources/remote/shopping_list_item_datasource_remote.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_datasource.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_items_datasource.dart';
import 'package:shoplanner/layers/data/datasources/users_datasource.dart';
import 'package:shoplanner/layers/data/repositories/item_repository_imp.dart';
import 'package:shoplanner/layers/data/repositories/price_repository_imp.dart';
import 'package:shoplanner/layers/data/repositories/shopping_list_item_repository_imp.dart';
import 'package:shoplanner/layers/data/repositories/shopping_list_repository_imp.dart';
import 'package:shoplanner/layers/data/repositories/user_repository_imp.dart';
import 'package:shoplanner/layers/domain/repositories/items_repository.dart';
import 'package:shoplanner/layers/domain/repositories/price_repository.dart';
import 'package:shoplanner/layers/domain/repositories/shopping_list_item_repository.dart';
import 'package:shoplanner/layers/domain/repositories/shopping_list_repository.dart';
import 'package:shoplanner/layers/domain/repositories/user_repository.dart';
import 'package:shoplanner/layers/domain/usecases/items_usecase/items_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/items_usecase/items_usecase_imp.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase_imp.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase_imp.dart';
import 'package:shoplanner/layers/domain/usecases/users_usecase/user_usecase.dart';
import 'package:shoplanner/layers/domain/usecases/users_usecase/user_usecase_imp.dart';
import 'package:shoplanner/layers/presentation/controllers/navigator_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_item_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/user_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    // Ordem ->
    // datasource
    getIt.registerLazySingleton<UsersDataSource>(
      () => UsersDataSourceMemory(),
    );
    getIt.registerLazySingleton<ShoppingListDataSource>(
      () => ShoppingListDataSourceRemote(),
    );
    getIt.registerLazySingleton<ShoppingListItemsDataSource>(
      () => ShoppingListItemDataSourceRemote(),
    );
    getIt.registerLazySingleton<ItemsDataSource>(
      () => ItemsDataSourceMemory(),
    );
    getIt.registerLazySingleton<PricesDataSource>(
      () => PriceDataSourceMemory(),
    );

    // repositories
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImp(getIt()),
    );
    getIt.registerLazySingleton<ShoppingListRepository>(
      () => ShoppingListRepositoryImp(getIt()),
    );
    getIt.registerLazySingleton<ShoppingListItemRepository>(
      () => ShoppingListItemRepositoryImp(getIt()),
    );
    getIt.registerLazySingleton<ItemsRepository>(() => ItemRepositoryImp(
          itemsDataSource: getIt(),
          pricesDataSource: getIt(),
        ));
    getIt.registerLazySingleton<PriceRepository>(
      () => PriceRepositoryImp(getIt()),
    );

    // usecases
    getIt.registerLazySingleton<UserUseCase>(
      () => UserUseCaseImp(getIt(), getIt()),
    );
    getIt.registerLazySingleton<ShoppingListUseCase>(
        () => ShoppingListUseCaseImpl(getIt()));
    getIt.registerLazySingleton<ShoppingListItemUseCase>(
      () => ShoppingListItemUseCaseImp(getIt()),
    );
    getIt.registerLazySingleton<ItemsUseCase>(
        () => ItemsUseCaseImp(getIt(), getIt()));

    // controllers
    getIt.registerLazySingleton(() => ShoppingListController(getIt()));
    getIt.registerLazySingleton(() => UserController(getIt()));
    getIt.registerLazySingleton(() => ShoppingListItemController(getIt()));
    getIt.registerLazySingleton(() => NavigatorController());
  }
}
