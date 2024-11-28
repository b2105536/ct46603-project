import 'package:flutter/material.dart';

import 'transfer_screen.dart';

class PaymentTransferScreen extends StatelessWidget {
  const PaymentTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              'Thanh toán & chuyển tiền',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thanh toán',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        _buildPaymentButton(
                          context,
                          icon: Icons.electrical_services,
                          label: 'Điện',
                          onPressed: () => _showPaymentForm(context),
                        ),
                        _buildPaymentButton(
                          context,
                          icon: Icons.water_drop,
                          label: 'Nước',
                          onPressed: () => _showPaymentForm(context),
                        ),
                        _buildPaymentButton(
                          context,
                          icon: Icons.home_filled,
                          label: 'Nhà trọ',
                          onPressed: () => _showPaymentForm(context),
                        ),
                        _buildPaymentButton(
                          context,
                          icon: Icons.wifi,
                          label: 'Internet',
                          onPressed: () => _showPaymentForm(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Chuyển tiền',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const TransferScreen(),
                          ),
                        );
                      },
                      child: const Text('Chuyển tiền'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(40),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, size: 30),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  void _showPaymentForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Nhà cung cấp',
                ),
                items: const [
                  DropdownMenuItem(value: 'A', child: Text('Nhà cung cấp A')),
                  DropdownMenuItem(value: 'B', child: Text('Nhà cung cấp B')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập mã hóa đơn',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Xác nhận'),
              ),
            ],
          ),
        );
      },
    );
  }
}
