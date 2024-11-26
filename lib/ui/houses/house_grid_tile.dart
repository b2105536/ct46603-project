import 'package:flutter/material.dart';

import '../../models/house.dart';
import '../../utils/currency_formatter.dart';
import 'house_detail_screen.dart';

class HouseGridTile extends StatelessWidget {
  const HouseGridTile(this.house, {super.key});

  final House house;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: HouseGridFooter(
          house: house,
          onSetAppointmentPressed: () {
            print('Set an appointment');
          },
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => HouseDetailScreen(house, house.rooms),
              ),
            );
          },
          child: Image.network(
            house.imageUrls[0],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Lỗi tải ảnh: $error');
              return const Icon(Icons.broken_image,
                  size: 100, color: Colors.grey);
            },
          ),
        ),
      ),
    );
  }
}

class HouseGridFooter extends StatelessWidget {
  const HouseGridFooter({
    super.key,
    required this.house,
    this.onSetAppointmentPressed,
  });

  final House house;
  final void Function()? onSetAppointmentPressed;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  house.name,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${CurrencyFormatter.format(house.rent)}/tháng',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.event_available),
            onPressed: onSetAppointmentPressed,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
