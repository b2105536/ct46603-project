import 'package:flutter/material.dart';

import 'houses_grid.dart';

class HousesOverviewScreen extends StatefulWidget {
  const HousesOverviewScreen({super.key});

  @override
  State<HousesOverviewScreen> createState() => _HousesOverviewScreenState();
}

class _HousesOverviewScreenState extends State<HousesOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khám phá'),
      ),
      body: const HousesGrid(),
    );
  }
}
