import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuyển tiền'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nguồn tiền chuyển',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Nguồn tiền',
              ),
              items: const [
                DropdownMenuItem(
                    value: 'bank', child: Text('Tài khoản ngân hàng')),
              ],
              onChanged: (value) {
                //Xử lý tại đây
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Chuyển đến',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Ngân hàng',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Số tài khoản',
                      ),
                      onChanged: (value) {
                        // Thêm logic tự động hiển thị tên ngân hàng/tên chủ thẻ ở đây
                      },
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Tên chủ thẻ',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Số tiền',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Nội dung chuyển tiền',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Xác nhận chuyển tiền'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
