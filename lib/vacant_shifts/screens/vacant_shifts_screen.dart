import 'package:flutter/material.dart';
import 'package:nation_job_connect/firebase/firestore_application.dart';
import 'package:nation_job_connect/firebase/firestore_nation.dart';
import 'package:nation_job_connect/firebase/firestore_shift_type.dart';
import 'package:nation_job_connect/firebase/firestore_user.dart';
import 'package:nation_job_connect/manage_application/models/application.dart';
import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/resources/utils.dart';
import 'package:nation_job_connect/user_profile/models/user.dart';
import 'package:nation_job_connect/shift_type/models/shift_type.dart';
import 'package:nation_job_connect/vacant_shifts/widgets/apply_dialog.dart';
import '../../resources/colors.dart';
import '../../widgets/common/alert_dialog.dart';
import '../../widgets/common/no_data.dart';
import '../../widgets/common/waiting.dart';
import '../../widgets/vacant_shifts/signin_dialog.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';
import '/firebase/firestore_connect.dart';

import '../models/vacant_shift.dart';

class VacantShiftScreen extends BaseScreen {

  @override
  State<VacantShiftScreen> createState() => _VacantShiftScreenState();
}

class _VacantShiftScreenState extends BaseState<VacantShiftScreen> with BasicScreen {

  final _dbConnect = FirebaseConnect();
  final _dbConnectNation = FirestoreNation();
  final _dbConnectApplication = FirestoreApplication();
  final _dbConnectUser = FirestoreUser();
  final _dbConnectShiftType = FirestoreShiftType();

  @override
  void initState() {
    _dbConnect.dbConnect();
    _dbConnectNation.dbConnect();
    _dbConnectApplication.dbConnect();
    _dbConnectUser.dbConnect();
    _dbConnectShiftType.dbConnect();
    super.initState();
  }
  
  @override
  getExtra() {
   
  }
  
  @override
  Widget screenBody(BuildContext context) {
    //load the all vacancies of all the nations as stream
    return StreamBuilder<List<VacantShift>>(
      stream: _dbConnect.getVacancies(), 
      builder: (context, snapshotVacantShifts) {
        if (snapshotVacantShifts.connectionState == ConnectionState.active) {
          var vacantShiftsList = snapshotVacantShifts.data;
          if (vacantShiftsList !=null && vacantShiftsList.isNotEmpty) {

            //Show list view of the vacant shifts...
            return ListView.builder(
              itemCount: vacantShiftsList.length,
              //Load the nation details using nation's id...
              itemBuilder: (ctx, i) => FutureBuilder(
                future: _dbConnectNation.readNationsList(vacantShiftsList[i].nation),
                builder: (BuildContext context, AsyncSnapshot<Nation> snapshot) {
                  var nation = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {

                    //Load the shift types list.......
                    return FutureBuilder(
                      future: _dbConnectShiftType.readShiftType(vacantShiftsList[i].shiftType),
                      builder: (BuildContext context, AsyncSnapshot<ShiftType> snapshotShiftType) { 

                        if (snapshotShiftType.connectionState == ConnectionState.done) {
                        var shiftType = snapshotShiftType.data;

                        return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(color: Color(ResColors.colorFontSplash), 
                          borderRadius: BorderRadius.all(Radius.circular(5)),),
                          child: Column(
                            children: [
                              Text("Nation: ${nation!.name}"),
                              Text("No of Vacancies: ${vacantShiftsList[i].noOfVacancies}"),
                              Text("No of Shift Hours: ${vacantShiftsList[i].shiftHours}"),
                              Text("Shift Type: ${shiftType!.type}"),
                              Text("Time: ${vacantShiftsList[i].time}"),
                            ],
                          ),
                        ),
                        onTap: () {
                          showDialog(context: context, builder: (context) {
                            return ApplyDialog("Confirmation", "Do you need to apply for this shift?", onApply: (){
                                var futureDeviceId = Utils.getDeviceId();
                                futureDeviceId.then((deviceId) {
                                  if (deviceId != null) {
                                      var futureUser = _dbConnectUser.readUser(deviceId);
                                      futureUser.then((user) {
                                        if (user != null && user.deviceId.isNotEmpty) {
                                          _dbConnectApplication.sendApplication(Application(vacantShiftsList[i].id, nation, 
                                            shiftType, vacantShiftsList[i].shiftHours, 
                                            vacantShiftsList[i].time, user.id!, user.name, user.fbProfile, user.deviceId));
                                        }else{
                                          showDialog(context: context,builder: (BuildContext contextSignIn) =>
                                              SigninDialog(onValidate: (firstName, fbProfile) async {
                                              
                                                Navigator.of(contextSignIn).pop();
                                                if (firstName.isEmpty || fbProfile.isEmpty) {
                                                  return showDialog(
                                                    context: contextSignIn, builder: (contextError) =>
                                                            const CustomAlertDialog('Error', "Please fill the required fields"));
                                                }else{
                                                  var user = User(deviceId: deviceId, name: firstName, fbProfile: fbProfile);
                                                  var futureUserId = _dbConnectUser.saveUser(user);
                                                  futureUserId.then((userId) {
                                                    _dbConnectApplication.sendApplication(Application(vacantShiftsList[i].id, nation, 
                                                      shiftType, vacantShiftsList[i].shiftHours, vacantShiftsList[i].time, 
                                                      userId, firstName, fbProfile, deviceId));
                                                  });
                                                  
                                                }
                                              }
                                            ));
                                        }
                                      });
                                  }
                                },);
                            });
                          
                                          
                         
                          });
                        },
                      );
                      }else {
                        return const NoData("No vacant shifts available");
                      }
                       },
                      
                    );
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return const Waiting();
                  }else{
                    return const NoData("No vacant shifts available");
                  }
                  
                 },
                
              )
          );
          }else{
            return const NoData("No vacant shifts available");
          }
          
        } else if (snapshotVacantShifts.connectionState == ConnectionState.waiting) {
          return const Waiting();
        } else {
          return const NoData("No vacant shifts available");
        }
        
      });
  }
  
  @override
  String screenName() {
    return "Vacant Shifts";
  }
}