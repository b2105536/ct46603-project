import 'package:flutter/material.dart';

class RentalRoomFormScreen extends StatelessWidget {
  const RentalRoomFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán Tiền trọ")),
      body: _buildForm(context, "Nhập thông tin về nhà trọ"),
    );
  }
}

class ElectricityFormScreen extends StatelessWidget {
  const ElectricityFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán Tiền điện")),
      body: _buildForm(context, "Nhập thông tin thanh toán điện"),
    );
  }
}

class WaterFormScreen extends StatelessWidget {
  const WaterFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán Tiền nước")),
      body: _buildForm(context, "Nhập thông tin thanh toán nước"),
    );
  }
}

class InternetFormScreen extends StatelessWidget {
  const InternetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán Tiền mạng")),
      body: _buildForm(context, "Nhập thông tin thanh toán dịch vụ Internet"),
    );
  }
}

class TemporaryResidenceFormScreen extends StatelessWidget {
  const TemporaryResidenceFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng ký tạm trú")),
      body: _buildRegistrationForm(context),
    );
  }
}

Widget _buildForm(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Nhà cung cấp',
          ),
          items: const [
            DropdownMenuItem(value: 'A', child: Text('Nhà cung cấp A')),
            DropdownMenuItem(value: 'B', child: Text('Nhà cung cấp B')),
          ],
          onChanged: (value) {
            // Xử lý sự kiện khi chọn nhà cung cấp
          },
        ),
        const SizedBox(height: 10),
        const TextField(
          decoration: InputDecoration(labelText: 'Mã hóa đơn'),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút
            },
            child: const Text('Xác nhận'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRegistrationForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nhập thông tin đăng ký tạm trú',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Họ và tên',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Ngày sinh',
            border: OutlineInputBorder(),
            hintText: 'dd/mm/yyyy',
          ),
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 10),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Địa chỉ đăng ký tạm trú',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              //Xử lý
            },
            child: const Text('Gửi'),
          ),
        ),
      ],
    ),
  );
}
