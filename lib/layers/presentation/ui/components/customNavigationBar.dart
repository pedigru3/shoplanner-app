import 'package:flutter/material.dart';
import 'customNavigationBarItem.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  final List<CustomNavigationBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentIndex;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  _handleSubmitIndex(int index) {
    setState(() {
      widget.onItemSelected(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 50,
            offset: const Offset(0, 3),
          ),
        ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items
                .asMap()
                .values
                .map<Widget>((item) => CustomNavigationBarItem(
                      iconData: item.iconData,
                      label: item.label,
                      isActive:
                          widget.currentIndex == widget.items.indexOf(item),
                      onTap: () {
                        _handleSubmitIndex(widget.items.indexOf(item));
                      },
                    ))
                .toList()));
  }
}

class NavigationBarData {
  IconData iconData;
  String label;
  NavigationBarData({required this.iconData, required this.label});
}
