import 'package:flutter/material.dart';

// import 'ui/houses/houses_manager.dart';
// import 'ui/houses/house_detail_screen.dart';
import 'ui/houses/houses_overview_screen.dart';
import 'ui/shared/custom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue.shade900,
      secondary: Colors.blue.shade600,
      surface: Colors.white,
      surfaceTint: Colors.blue.shade100,
    );

    final themeData = ThemeData(
      fontFamily: 'Lato',
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shadowColor: colorScheme.shadow,
      ),
    );

    return MaterialApp(
      title: 'C-Housing',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const MyHomePage(title: 'C-House'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const Text('Trang chủ'),
    const Text('Lịch sử'),
    const Text('Thanh toán'),
    const HousesOverviewScreen(),
    const Text('Hồ sơ'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Colors.grey.withOpacity(0.6),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_alt),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Thanh toán',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Hồ sơ',
          )
        ],
      ),
    );
  }
}
