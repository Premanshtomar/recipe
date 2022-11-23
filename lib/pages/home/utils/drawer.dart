import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/utils/alert_dialog.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final email = FirebaseAuth.instance.currentUser?.displayName;
  final imageUrl =
      'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
                decoration: const BoxDecoration(color: Colors.white),
                margin: EdgeInsets.zero,
                accountName: Text(
                  email ?? 'Not logged in',
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                accountEmail: null,
              ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(
              CupertinoIcons.home,
              color: Colors.black,
            ),
            title: const Text(
              'Home',
              textScaleFactor: 2,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              showEmailDialog(context, email ?? 'Not Logged in');
            },
            leading: const Icon(
              CupertinoIcons.mail,
              color: Colors.black,
            ),
            title: const Text(
              'Email',
              textScaleFactor: 2,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // ignore: use_build_context_synchronously
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/logging/", (route) => false);
                }
              }
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text(
              'Log Out',
              textScaleFactor: 2,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
