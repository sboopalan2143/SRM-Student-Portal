import 'package:flutter/material.dart';
import 'package:sample/designs/colors.dart';

class MenuItems {
  static const main = MenuItem('Home', Icons.home_outlined);
  static const home = MenuItem('', Icons.arrow_back_ios_new);
  static const all = <MenuItem>[main, home];
}

class MenuItem {
  const MenuItem(this.title, this.icon);
  final String title;
  final IconData icon;
}

class MenuPageTheme4 extends StatelessWidget {
  const MenuPageTheme4({
    required this.currentItem,
    required this.onSelectedItem,
    super.key,
  });
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColorTheme3,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );
}
