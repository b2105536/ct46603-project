import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'histories_manager.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/histories';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historiesManager = Provider.of<HistoriesManager>(context);
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    final filteredRecords =
        historiesManager.getRecordsByMonth(currentMonth, currentYear);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'Lịch sử',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(text: "Giao dịch"),
                  Tab(text: "Di chuyển"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(child: Text("Không có giao dịch nào")),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (filteredRecords.isNotEmpty)
                            Text(
                              "Tháng $currentMonth",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (filteredRecords.isNotEmpty)
                            const SizedBox(height: 8),
                          ...filteredRecords.map(
                            (record) => Dismissible(
                              key: ValueKey(record.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              onDismissed: (direction) {
                                historiesManager.removeRecord(record.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text("Đã xóa lịch hẹn"),
                                    action: SnackBarAction(
                                      label: 'Hoàn tác',
                                      onPressed: () {
                                        historiesManager.addRecord(record);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            record.houseName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            record.status,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  record.status == "Chờ xử lý"
                                                      ? Colors.orange
                                                      : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Thời gian đặt lịch:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            DateFormat('HH:mm - dd/MM/yyyy')
                                                .format(record.timestamp),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
