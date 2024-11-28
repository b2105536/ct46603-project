import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.name,
    required this.mobile,
    required this.imageProvider,
  });

  final String name;
  final String mobile;
  final String imageProvider;

  @override
  Widget build(BuildContext context) {
    final ImageProvider avatar = (imageProvider.isEmpty)
        ? const AssetImage('assets/images/default_avatar.png')
        : AssetImage(imageProvider);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: CircleAvatar(
                  backgroundImage: avatar,
                  radius: 25,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    mobile,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
