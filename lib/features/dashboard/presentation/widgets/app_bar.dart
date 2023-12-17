import 'package:dexter_health/utils/utils.dart';
import 'package:flutter/material.dart';

class DexterAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DexterAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: appColors.blue,
            child: Icon(
              Icons.person_rounded,
              color: appColors.white,
              size: 30,
            ),
          ),
          XBox(15.dx),
          Text(
            'Eren',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: appColors.black,
              height: 1.1,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: hPadding),
          child: Icon(
            Icons.more_vert_rounded,
            color: appColors.icon,
            size: 26,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
