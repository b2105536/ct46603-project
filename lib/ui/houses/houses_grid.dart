import 'package:flutter/material.dart';

import '../../models/house.dart';
import 'house_grid_tile.dart';

class HousesGrid extends StatelessWidget {
  final List<House> houses;

  const HousesGrid({super.key, required this.houses});

  @override
  Widget build(BuildContext context) {
    if (houses.isEmpty) {
      return const Center(
        child: Text('Hiện chưa có nhà trọ nào để hiển thị!'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
      ),
      itemCount: houses.length,
      itemBuilder: (ctx, i) {
        return HouseGridTile(houses[i]);
      },
    );
  }
}
