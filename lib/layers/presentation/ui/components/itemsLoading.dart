import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ItemsLoading extends StatelessWidget {
  const ItemsLoading({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
                width: width * 0.39,
                height: 45,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 2),
          SkeletonLine(
            style: SkeletonLineStyle(
                width: width * 0.19,
                height: 45,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 2),
          SkeletonLine(
            style: SkeletonLineStyle(
                width: width * 0.19,
                height: 45,
                borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
