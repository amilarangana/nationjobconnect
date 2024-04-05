import 'package:flutter/material.dart';
import 'package:nation_job_connect/firebase/firestore_application.dart';
import 'package:nation_job_connect/firebase/firestore_my_shifts.dart';
import 'package:nation_job_connect/firebase/firestore_user.dart';
import 'package:nation_job_connect/my_shifts/widgets/decline_dialog.dart';
import '../../resources/utils.dart';
import '../../user_profile/models/user.dart';
import '/my_shifts/models/my_application.dart';
import '../../resources/colors.dart';
import '../../widgets/common/no_data.dart';
import '../../widgets/common/waiting.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';

class MyShiftScreen extends BaseScreen {
  MyShiftScreen({super.key});


  @override
  State<MyShiftScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends BaseState<MyShiftScreen> with BasicScreen {

  final _dbConnectMyShifts = FirestoreMyShifts();
  final _dbConnectApplication = FirestoreApplication();
  final _dbConnectUser = FirestoreUser();

  @override
  void initState() {
    _dbConnectMyShifts.dbConnect();
    _dbConnectApplication.dbConnect();
    _dbConnectUser.dbConnect();
    super.initState();
  }
  
  @override
  getExtra() {
   
  }
  
  @override
  Widget screenBody(BuildContext context) {
  //Load the device id....
   return FutureBuilder(
      future: Utils.getDeviceId(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotDeviceId) { 
        var deviceId = snapshotDeviceId.data;
          if (deviceId != null) {

            //Load the user id....
            return FutureBuilder(
              future: _dbConnectUser.readUser(deviceId), 
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotUser) {
                User? user = snapshotUser.data;
                if (user != null && user.id != null) {

                  //load all user applied vacancies...
                  return StreamBuilder<List<MyApplication>>(
                      stream: _dbConnectMyShifts.getMyShifts(user.id!), 
                      builder: (context, snapshotMyShifts) {
                        if (snapshotMyShifts.connectionState == ConnectionState.active) {
                          var myShiftsList = snapshotMyShifts.data;
                          if (myShiftsList !=null && myShiftsList.isNotEmpty) {

                            //Show list view of the applied shifts...
                            return ListView.builder(
                              itemCount: myShiftsList.length,
                              //Load the nation details using nation's id...
                              itemBuilder: (ctx, i) => GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(5),
                                        
                                        decoration: BoxDecoration(color: Color(myShiftsList[i].status == 0 ? ResColors.colorYellow: 
                                        (myShiftsList[i].status == 1 ? ResColors.colorGreen :ResColors.colorRed)),
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),),
                                        child: Column(
                                          children: [
                                            Text(myShiftsList[i].nation.name),
                                            Text("Status: ${myShiftsList[i].status == 0? "Pending":(myShiftsList[i].status == 1? "Approved": "Rejected")}"),
                                            Text("Shift Hours: ${myShiftsList[i].shiftHours}"),
                                            Text("Shift Type: ${myShiftsList[i].shiftType.type}"),
                                            Text("Time: ${myShiftsList[i].time}"),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(context: context, builder: (context) {
                                          return DeclineDialog("Confirmation", "Do you need to decline this application?", onDecline: (){
                                            _dbConnectApplication.removeApplication(user.id!, myShiftsList[i].vacancyId, myShiftsList[i].id);
                                          });
                                        });
                                      },
                                    )
                                  
                          );
                          }else{
                            return const NoData("No My shifts available");
                          }
                          
                        } else if (snapshotMyShifts.connectionState == ConnectionState.waiting) {
                          return const Waiting();
                        } else {
                          return const NoData("No My shifts available");
                        }
        
                  });
              }else{
                return const NoData('No My shifts available');
              }
          });
      }else{
        return const NoData('No My shifts available');
      }
    });
    
  }
  
  @override
  String screenName() {
    return "My Shifts";
  }
}