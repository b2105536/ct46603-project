import 'package:flutter/material.dart';
import '../users/users_manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final usersManager = UsersManager().getUserByPhoneNumber('0123456789');

    final ImageProvider avatar = (usersManager.avatar.isEmpty)
        ? const AssetImage('assets/images/default_avatar.png')
        : AssetImage(usersManager.avatar);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade100),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: CircleAvatar(
                    backgroundImage: avatar,
                    radius: 38,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usersManager.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      usersManager.mobile,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Đăng xuất'),
            onTap: () {
              // Chức năng xử lý đăng xuất sẽ được thêm sau
            },
          ),
        ],
      ),
    );
  }
}
