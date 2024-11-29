import 'dart:async';

import 'package:flutter/material.dart';

import 'homepage/quick_functions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.toInt() + 1) % 5;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            // Card "Chức năng nhanh"
            _buildQuickFunctions(),
            // Slideshow
            _buildSlideshow(),
            // Tiện ích và hỗ trợ nhanh
            // _buildQuickSupport(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFunctions() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chức năng nhanh",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFunctionButton(
                    context,
                    icon: Icons.home_filled,
                    label: "Trọ",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const RentalRoomFormScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFunctionButton(
                    context,
                    icon: Icons.electrical_services,
                    label: "Điện",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const ElectricityFormScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFunctionButton(
                    context,
                    icon: Icons.water_drop,
                    label: "Nước",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const WaterFormScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFunctionButton(
                    context,
                    icon: Icons.wifi,
                    label: "Internet",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const InternetFormScreen(),
                        ),
                      );
                    },
                  ),
                  _buildFunctionButton(
                    context,
                    icon: Icons.how_to_reg,
                    label: "Đăng ký tạm trú",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              const TemporaryResidenceFormScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
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
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSlideshow() {
    return SizedBox(
      height: 250,
      child: PageView(
        controller: _pageController,
        children: [
          Image.network(
            'https://s3-ap-northeast-1.amazonaws.com/wp-gogovan.com/wp-content/uploads/sites/6/2020/11/15232348/Untitled-1-20-scaled.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://chuyennhamiennam.com/wp-content/uploads/2024/10/dich-vu-chuyen-nha-tro-1400x789.webp',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://onehome.vn/wp-content/uploads/2023/09/xoa-tan-1.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://tromoi.com/uploads/static/Blog/Giai-phap-f5/THUMP-TRO-811-01.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://lozido.com/images/banner-tim-phong-tro.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  // Widget _buildQuickSupport() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Tiện ích và hỗ trợ nhanh",
  //             style: Theme.of(context).textTheme.titleLarge),
  //         const SizedBox(height: 10),
  //         Wrap(
  //           spacing: 8.0,
  //           runSpacing: 4.0,
  //           children: [
  //             Chip(
  //               label: const Text("Hỗ trợ khách hàng"),
  //               onPressed: () {
  //                 // Điều hướng đến trang hỗ trợ khách hàng
  //               },
  //             ),
  //             Chip(
  //               label: const Text("Tài khoản ngân hàng"),
  //               onPressed: () {
  //                 // Điều hướng đến trang tài khoản ngân hàng
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
