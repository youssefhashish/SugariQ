import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onProfileTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const Sidebar({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.onProfileTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                userName.isNotEmpty ? userName[0] : '',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF85C26F),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: onProfileTap,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: onSettingsTap,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}