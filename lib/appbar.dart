import 'package:flutter/material.dart';

import 'colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    final AppBar appBar;
  const CustomAppBar({
    super.key, required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "قُطْرُب: تصريف الأفعال العربية",
        style: TextStyle(color: primaryColor),
      ),
      backgroundColor: backgroundColor,
      elevation: 0.5,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: primaryColor,
            ))
      ],
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(appBar.preferredSize.height);
}
