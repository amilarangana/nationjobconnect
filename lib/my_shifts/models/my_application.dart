import 'package:cloud_firestore/cloud_firestore.dart';

import '../../nations/models/nation.dart';
import '../../shift_type/models/shift_type.dart';

class MyApplication{
  final String id;
  final String vacancyId;
  final Nation nation;
  final ShiftType shiftType;
  final DateTime endTime;
  final DateTime time;
  final int status;

  MyApplication({required this.id, required this.vacancyId, required this.nation, required this.shiftType, required this.endTime, 
  required this.time, required this.status, });

factory MyApplication.fromJson(String id, Map<String, dynamic> doc) {
    return MyApplication(
      id: id,
      vacancyId: doc['vacancy_id'] as String,
      nation: Nation.fromShortJson(doc['nation']),
      time: DateTime.fromMillisecondsSinceEpoch(
            (doc['time'] as Timestamp).millisecondsSinceEpoch),
      shiftType: ShiftType.fromShortJson(doc['shift_type']),
      endTime: DateTime.fromMillisecondsSinceEpoch(
            (doc['end_time'] as Timestamp).millisecondsSinceEpoch),
      status: doc['status'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nation': nation,
      'time': time,
      'shift_type' : shiftType,
      'end_time' : endTime
    };
  }
}