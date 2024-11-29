import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens.dart';
import 'ui/shared/custom_app_bar.dart';
import 'ui/shared/app_drawer.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => HousesManager()),
        ChangeNotifierProvider(create: (ctx) => HistoriesManager()),
        ChangeNotifierProvider(create: (ctx) => UsersManager()),
      ],
      child: MaterialApp(
        title: 'C-Housing',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const MyHomePage(title: 'C-House'),
        routes: {
          HistoryScreen.routeName: (ctx) =>
              const SafeArea(child: HistoryScreen()),
          PaymentTransferScreen.routeName: (ctx) =>
              const SafeArea(child: PaymentTransferScreen()),
          HousesOverviewScreen.routeName: (ctx) =>
              const SafeArea(child: HousesOverviewScreen()),
          UserScreen.routeName: (ctx) =>
              const SafeArea(child: UserScreen(userPhoneNumber: '0123456789')),
        },
        onGenerateRoute: (settings) {
          if (settings.name == HouseDetailScreen.routeName) {
            final houseId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (ctx) {
                return SafeArea(
                  child: HouseDetailScreen(
                      ctx.read<HousesManager>().findById(houseId)!,
                      ctx.read<HousesManager>().findById(houseId)!.rooms),
                );
              },
            );
          }
          return null;
        },
      ),
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
    const HomeScreen(),
    const HistoryScreen(),
    const PaymentTransferScreen(),
    const HousesOverviewScreen(),
    const UserScreen(userPhoneNumber: '0123456789'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      endDrawer: const AppDrawer(),
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
