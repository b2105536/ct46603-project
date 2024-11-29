import 'package:flutter/material.dart';

import '../../models/house.dart';
import 'houses_grid.dart';
import 'houses_manager.dart';

class HousesOverviewScreen extends StatefulWidget {
  static const routeName = '/houses';

  const HousesOverviewScreen({super.key});

  @override
  State<HousesOverviewScreen> createState() => _HousesOverviewScreenState();
}

class _HousesOverviewScreenState extends State<HousesOverviewScreen> {
  final TextEditingController searchController = TextEditingController();
  List<House> filteredHouses = [];
  final HousesManager housesManager = HousesManager();

  @override
  void initState() {
    super.initState();
    filteredHouses = housesManager.houses;
  }

  void _filterHouses(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredHouses = housesManager.houses;
      } else {
        filteredHouses = housesManager.houses.where((house) {
          final nameMatch =
              house.name.toLowerCase().contains(query.toLowerCase());
          final rentMatch = house.rent.toString().contains(query);
          return nameMatch || rentMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              'Khám phá',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterHouses,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(child: HousesGrid(houses: filteredHouses)),
        ],
      ),
    );
  }
}
