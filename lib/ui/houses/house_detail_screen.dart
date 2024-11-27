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
  final GlobalKey _imageContainerKey = GlobalKey();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _imageHeight = 250;
  Room? _selectedRoom;

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
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: (details) {
          if (_selectedRoom == null) {
            setState(() {
              _imageHeight += details.primaryDelta!;
              _imageHeight = _imageHeight.clamp(250.0, 400.0);
            });
          }
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Danh sách phòng (Còn ${widget.rooms.where((room) => room.status == 'Còn trống').length} phòng trống)",
                  style: const TextStyle(
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
                        setState(() {
                          if (_selectedRoom == room) {
                            _selectedRoom = null;
                            _imageHeight = 250;
                          } else {
                            _selectedRoom = room;
                            _imageHeight = 250;
                          }
                        });
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
              const SizedBox(height: 16),
              if (_selectedRoom != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Thông tin chi tiết",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Phòng: ${_selectedRoom!.number}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Diện tích: ${_selectedRoom!.square} m²',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Trạng thái: ${_selectedRoom!.status}',
                            style: TextStyle(
                              fontSize: 16,
                              color: _selectedRoom!.status == 'Còn trống'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          if (_selectedRoom!.status == 'Đã cho thuê')
                            Text(
                              'Ngày thuê: ${_selectedRoom!.rentDay.day}/${_selectedRoom!.rentDay.month}/${_selectedRoom!.rentDay.year}',
                              style: const TextStyle(fontSize: 16),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final appBarColor = Theme.of(context).appBarTheme.backgroundColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          color: Colors.black,
          margin: const EdgeInsets.symmetric(horizontal: 15),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              color: appBarColor?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.contact_phone),
                  onPressed: () {
                    _showContactDialog(context, widget.house.contact);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Đã lên lịch hẹn');
                    // Xử lý logic lên lịch hẹn ở đây
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBarColor,
                  ),
                  child: const Text(
                    'Lên lịch hẹn',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Đặt thành công');
                    // Xử lý logic đặt ngay ở đây
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Đặt ngay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showContactDialog(BuildContext context, String contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.contact_phone),
              SizedBox(width: 8),
              Text("Liên hệ"),
            ],
          ),
          content: Text("Số điện thoại: $contact"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Thoát"),
            ),
          ],
        );
      },
    );
  }
}
