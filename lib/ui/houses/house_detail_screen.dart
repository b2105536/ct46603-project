import 'package:flutter/material.dart';

import '../../models/house.dart';
import '../../models/room.dart';
import '../../utils/currency_formatter.dart';

class HouseDetailScreen extends StatefulWidget {
  final House house;
  final List<Room> rooms;

  const HouseDetailScreen(this.house, this.rooms, {super.key});

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _imageHeight = 250;
  final GlobalKey _imageContainerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.house.name),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _imageHeight =
                (_imageHeight + details.delta.dy).clamp(250.0, 400.0);
          });
        },
        onHorizontalDragUpdate: (details) {
          RenderBox renderBox = _imageContainerKey.currentContext!
              .findRenderObject() as RenderBox;
          Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);
          if (renderBox.size.contains(localPosition)) {
            if (details.delta.dx > 0) {
              if (_currentPage > 0) {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }
            } else {
              if (_currentPage < widget.house.imageUrls.length - 1) {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: _imageHeight,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.house.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.house.imageUrls[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Text('Không tải được ảnh')),
                        );
                      },
                    ),
                  ),
                  if (widget.house.imageUrls.length > 1)
                    Positioned(
                      bottom: 8,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${_currentPage + 1}/${widget.house.imageUrls.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${CurrencyFormatter.format(widget.house.rent)}/tháng',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(widget.house.address)),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(widget.house.description)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Danh sách phòng",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: widget.rooms.length,
                  itemBuilder: (context, index) {
                    final room = widget.rooms[index];
                    return ElevatedButton(
                      onPressed: () {
                        // Mở thông tin chi tiết phòng
                      },
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          'P${room.number}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
