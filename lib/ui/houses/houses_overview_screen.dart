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
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              'Khám phá',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Expanded(child: HousesGrid()),
        ],
      ),
    );
  }
}
