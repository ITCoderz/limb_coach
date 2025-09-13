import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

/// 🔹 Drawer Item Model
class DrawerItem {
  final String icon;
  final String title;
  final VoidCallback onTap;

  DrawerItem({required this.icon, required this.title, required this.onTap});
}

/// 🔹 Side Menu Widget
Widget sideMenu({
  required List<DrawerItem> items,
  required VoidCallback onLogout,
}) {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 190,
          child: DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(Assets.pngIconsLogo, height: 89),
                ),
              ],
            ),
          ),
        ),
        // Generate all items dynamically
        ...items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(left: 10),
                child: _drawerItem(item),
              ),
            )
            .toList(),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListTile(
            leading: Image.asset(Assets.pngIconsLogout, height: 35),
            title: Text(
              "Log Out",
              style: AppTextStyles.getLato(14, 4.weight, AppColors.redColor),
            ),
            onTap: onLogout,
          ),
        ),
      ],
    ),
  );
}

/// 🔹 Drawer Item Widget
Widget _drawerItem(DrawerItem item) {
  return ListTile(
    leading: Image.asset(item.icon, color: AppColors.primaryColor, height: 35),
    title: Text(item.title, style: AppTextStyles.getLato(14, 4.weight)),
    onTap: item.onTap,
  );
}
