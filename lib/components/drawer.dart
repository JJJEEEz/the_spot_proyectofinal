import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function() onProfileTap;
  final void Function() onSignOutTap;
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Encabezado
                  DrawerHeader(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),

                  // Home title
                  MyListTile(
                    icon: Icons.home_sharp,
                    text: 'H O M E',
                    onTap: () => Navigator.pop(context),
                  ),

                  // Perfil tile
                  MyListTile(
                    icon: Icons.person,
                    text: 'P R O F I L E',
                    onTap: onProfileTap,
                  ),
                ],
              ),

              // logout tile
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: MyListTile(
                  icon: Icons.logout_sharp,
                  text: 'L O G O U T',
                  onTap: onSignOutTap,
                ),
              )
            ]));
  }
}
