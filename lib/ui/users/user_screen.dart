import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

import 'users_manager.dart';
import 'user_card.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/user';

  final String userPhoneNumber;

  const UserScreen({super.key, required this.userPhoneNumber});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late User user;
  bool gender = false;
  late String tempName;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController temaddController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userManager = context.read<UsersManager>();
    user = userManager.getUserByPhoneNumber(widget.userPhoneNumber);

    tempName = user.name;
    nameController.text = tempName;
    dobController.text = user.dob != null
        ? "${user.dob!.day}/${user.dob!.month}/${user.dob!.year}"
        : '';
    temaddController.text = user.temadd ?? '';
    gender = user.gender;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserCard(
                name: tempName,
                mobile: user.mobile,
                imageProvider: user.avatar,
              ),
              const SizedBox(height: 20),
              _buildEditableRow(
                label: 'Giới tính:',
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('Anh'),
                      selected: gender,
                      onSelected: (selected) {
                        setState(() {
                          gender = true;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Chị'),
                      selected: !gender,
                      onSelected: (selected) {
                        setState(() {
                          gender = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              _buildEditableRow(
                label: 'Họ và tên:',
                child: _buildEditableTextField(
                  controller: nameController,
                  hintText: 'Nhập họ và tên',
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              _buildEditableRow(
                label: 'Điện thoại:',
                child: _buildReadOnlyTextField(
                  initialValue: user.mobile,
                ),
              ),
              _buildEditableRow(
                label: 'Ngày sinh:',
                child: _buildEditableTextField(
                  controller: dobController,
                  hintText: 'Nhập ngày sinh',
                ),
              ),
              _buildEditableRow(
                label: 'Địa chỉ thường trú: ',
                child: _buildReadOnlyTextField(
                  initialValue: user.peradd,
                ),
              ),
              _buildEditableRow(
                label: 'Địa chỉ tạm trú: ',
                child: _buildEditableTextField(
                  controller: temaddController,
                  hintText: 'Nhập địa chỉ tạm trú',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    final updatedUser =
                        user.copyWith(name: nameController.text);
                    final userManager = context.read<UsersManager>();
                    userManager.updateUser(user.id, updatedUser);

                    setState(() {
                      user = updatedUser;
                      tempName = user.name;
                    });

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Cập nhật'),
                        content: const Text('Thông tin đã được cập nhật.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Cập nhật',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableRow({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required String hintText,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: const Icon(Icons.edit),
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  Widget _buildReadOnlyTextField({required String initialValue}) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      readOnly: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.grey),
    );
  }
}
