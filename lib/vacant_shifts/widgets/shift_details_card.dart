import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/resources/colors.dart';
import 'package:nation_job_connect/resources/utils.dart';
import 'package:nation_job_connect/shift_type/models/shift_type.dart';
import 'package:nation_job_connect/vacant_shifts/models/vacant_shift.dart';
import 'package:nation_job_connect/vacant_shifts/widgets/custom_container.dart';

class ShiftDetailsCard extends StatelessWidget {
  void Function()? onTap;
  Nation? nation;
  VacantShift vacantShift;
  ShiftType? shiftType;

  ShiftDetailsCard({
    super.key,
    required this.nation,
    required this.onTap,
    required this.vacantShift,
    required this.shiftType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    nation?.name ?? "",
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    nation?.logo ?? "",
                    width: 70,
                    height: 70,
                  ),
                  // Image.asset(
                  //   'assets/images/upland_logo.png',
                  //   height: 80,
                  //   width: 60,
                  // ),
                ],
              ),
            ),
            Container(
              width: 5,
              height: 120, // Thickness
              color: Colors.grey.shade400,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shiftType?.type ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                Text("Date: ${Utils.getDate(vacantShift.time)}"),
                Text(
                    "Hours: ${Utils.getTime(vacantShift.time)} - ${Utils.getTime(vacantShift.endTime)}"),
                Text(
                  "${vacantShift.noOfVacancies} Shifts available",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${vacantShift.wage} Kr/Hour",
                  style: TextStyle(fontSize: 13),
                ),

                const CustomContainer(
                  title: "No Experience Needed",
                  background: Colors.green,
                ),

                // CustomContainer(
                //   title: "Experience Needed",
                //   background: Colors.red.shade200,
                // )
              ],
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_right,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
