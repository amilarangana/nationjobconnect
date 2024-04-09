import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nation_job_connect/my_shifts/models/my_application.dart';
import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/resources/utils.dart';
import 'package:nation_job_connect/shift_type/models/shift_type.dart';
import 'package:nation_job_connect/vacant_shifts/models/vacant_shift.dart';
import 'package:nation_job_connect/vacant_shifts/widgets/custom_container.dart';

class MyShiftDetailsCard extends StatelessWidget {
  void Function()? onTap;
  Nation nation;
  MyApplication myApplication;
  ShiftType? shiftType;

  MyShiftDetailsCard({
    super.key,
    required this.nation,
    required this.onTap,
    required this.myApplication,
    required this.shiftType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: myApplication.status == 1
              ? Color.fromARGB(255, 193, 240, 196)
              : (myApplication.status == 2
                  ? Color.fromARGB(255, 240, 159, 153)
                  : Colors.white),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    nation?.logo ?? "",
                    width: 70,
                    height: 70,
                  ),
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

                Text("Date: ${Utils.getDate(myApplication.time)}"),
                Text(
                    "Hours: ${Utils.getTime(myApplication.time)} - ${Utils.getTime(myApplication.endTime)}"),
                Text(
                  "${myApplication.status == 0 ? "Pending" : (myApplication.status == 1 ? "Approved" : "Rejected")}",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
