import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';

class SliderUser extends StatelessWidget {
  const SliderUser({
    super.key,
    required this.onDismissed,
    required this.user,
  });

  final UserEntity user;
  final Function(UserEntity) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(user.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          onDismissed(user);
        }),
        children: [
          SlidableAction(
            onPressed: (_) => {
              onDismissed(user),
            },
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFFE4A49),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.image ??
                  'https://cdn-icons-png.flaticon.com/512/121/121693.png'),
            ),
            const SizedBox(width: 10),
            Text(
              user.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
