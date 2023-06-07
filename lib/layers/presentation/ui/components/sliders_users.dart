import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/presentation/controllers/user_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/slider_user.dart';
import 'package:shoplanner/layers/presentation/ui/pages/homePage.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/errors/user_exception.dart';

class SlidersUsers extends StatefulWidget {
  const SlidersUsers({super.key});

  @override
  State<SlidersUsers> createState() => _SlidersUsersState();
}

class _SlidersUsersState extends State<SlidersUsers> {
  final userController = GetIt.I.get<UserController>();
  Result<List<UserEntity>, UserException>? users;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    users = await userController.fetchAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return users != null
        ? users!.fold((users) {
            return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      userController.setUser(users[index]);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ));
                    },
                    child: SliderUser(
                      user: users[index],
                      onDismissed: (value) =>
                          setState(() => users.remove(value)),
                    ),
                  );
                });
          }, (failure) {
            return const Center(child: Text('Erro ao carregar usuários'));
          })
        : const Center(child: CircularProgressIndicator());
  }
}
