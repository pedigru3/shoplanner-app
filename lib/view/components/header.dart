import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    const double height = 80;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  text2,
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://img.freepik.com/free-vector/elegant-red-background_1340-4770.jpg',
            ),
            radius: 32,
            backgroundColor: Colors.black,
          )
        ],
      ),
    );
  }
}
