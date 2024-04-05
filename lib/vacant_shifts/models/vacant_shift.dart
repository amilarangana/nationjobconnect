
import 'package:cloud_firestore/cloud_firestore.dart';

class VacantShift{
  final String id;
  final String nation;
  final int noOfVacancies;
  final String shiftType;
  final double shiftHours;
  final DateTime time;

  VacantShift({
    required this.id, 
    required this.nation, 
    required this.noOfVacancies, 
    required this.shiftType, 
    required this.shiftHours, 
    required this.time
    });

  factory VacantShift.fromJson(String id, Map<String, dynamic> doc) {
    return VacantShift(
      id: id,
      nation: doc['nation'] as String,
      noOfVacancies: doc['no_of_vacancies'] as int,
      time: DateTime.fromMillisecondsSinceEpoch(
            (doc['time'] as Timestamp).millisecondsSinceEpoch),
      shiftType: doc['position'] as String,
      shiftHours: doc['shift_hours'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nation': nation,
      'no_of_vacancies': noOfVacancies,
      'time': time,
      'position' : shiftType,
      'shift_hours' : shiftHours
    };
  }
}