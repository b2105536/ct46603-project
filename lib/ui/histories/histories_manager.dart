import 'package:flutter/material.dart';

import '../../models/history.dart';

class HistoriesManager with ChangeNotifier {
  final List<AppointmentHistory> _records = [];

  List<AppointmentHistory> get records => [..._records];

  void addRecord(AppointmentHistory record) {
    _records.add(record);
    notifyListeners();
  }

  void removeRecord(String id) {
    _records.removeWhere((record) => record.id == id);
    notifyListeners();
  }

  List<AppointmentHistory> getRecordsByMonth(int month, int year) {
    return _records.where((record) {
      return record.timestamp.month == month && record.timestamp.year == year;
    }).toList();
  }
}
