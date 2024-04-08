
import 'package:cloud_firestore/cloud_firestore.dart';

class VacantShift{
  late String id;
  final String nation;
  final int noOfVacancies;
  final String shiftType;
  final double wage;
  final DateTime time;
  final DateTime endTime;
  final int status;

  VacantShift(this.id, 
   {
    required this.nation, 
    required this.noOfVacancies, 
    required this.shiftType, 
    required this.time,
    required this.wage, 
    required this.endTime,
    required this.status, 
  });

  factory VacantShift.fromJson(String id, Map<String, dynamic> doc) {
    return VacantShift(
      id,
      nation: doc['nation'] as String,
      noOfVacancies: doc['no_of_vacancies'] as int,
      time: DateTime.fromMillisecondsSinceEpoch(
            (doc['time'] as Timestamp).millisecondsSinceEpoch),
      shiftType: doc['position'] as String,
      wage: doc['wage'] as double, 
      endTime: DateTime.fromMillisecondsSinceEpoch(
            (doc['end_time'] as Timestamp).millisecondsSinceEpoch),
      status:  doc['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nation': nation,
      'no_of_vacancies': noOfVacancies,
      'time': time,
      'end_time': endTime,
      'position' : shiftType,
      'wage': wage,
      'status' : status
    };
  }
}