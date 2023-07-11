import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_list_tile.dart';

import 'constants/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
    this.onProfileTap,
    this.onSignOutTap,
  });
  final Function()? onProfileTap;
  final Function()? onSignOutTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.scaffoldBgColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // header

            Column(
              children: [
                const DrawerHeader(
                    child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                )),
                //home ListTile
                MyListTile(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () => Navigator.pop(context),
                ),
                MyListTile(
                  icon: Icons.person,
                  text: 'Profile',
                  onTap: onProfileTap,
                ),
              ],
            ),
            MyListTile(
              icon: Icons.logout,
              text: 'Logout',
              onTap: onSignOutTap,
            )
            // logout
          ],
        ),
      ),
    );
  }
}
