import 'package:flutter/material.dart';

import 'house_grid_tile.dart';
import 'houses_manager.dart';

class HousesGrid extends StatelessWidget {
  const HousesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final housesManager = HousesManager();
    final houses = housesManager.houses;

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
