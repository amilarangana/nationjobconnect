import 'package:flutter/material.dart';
import '../../firebase/firestore_my_shifts.dart';
import '../../my_shifts/models/my_application.dart';
import '/authentication/screens/signin_screen.dart';
import '/firebase/firestore_application.dart';
import 'package:nation_job_connect/firebase/firestore_nation.dart';
import 'package:nation_job_connect/firebase/firestore_shift_type.dart';
import 'package:nation_job_connect/firebase/firestore_user.dart';
import 'package:nation_job_connect/manage_application/models/application.dart';
import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/shift_type/models/shift_type.dart';
import 'package:nation_job_connect/vacant_shifts/widgets/apply_dialog.dart';
import 'package:nation_job_connect/vacant_shifts/widgets/shift_details_card.dart';
import '../../authentication/store_credentials/auth_shared_prefs.dart';
import '../../widgets/common/no_data.dart';
import '../../widgets/common/waiting.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';
import '/firebase/firestore_connect.dart';

import '../models/vacant_shift.dart';

class VacantShiftScreen extends BaseScreen {
  @override
  State<VacantShiftScreen> createState() => _VacantShiftScreenState();
}

class _VacantShiftScreenState extends BaseState<VacantShiftScreen>
    with BasicScreen {
  final _dbConnect = FirebaseConnect();
  final _dbConnectMyShifts = FirestoreMyShifts();
  final _dbConnectNation = FirestoreNation();
  final _dbConnectApplication = FirestoreApplication();
  final _dbConnectUser = FirestoreUser();
  final _dbConnectShiftType = FirestoreShiftType();

  final _authShredPrefs = AuthSharedPrefs();

  @override
  void initState() {
    _dbConnect.dbConnect();
     _dbConnectMyShifts.dbConnect();
    _dbConnectNation.dbConnect();
    _dbConnectApplication.dbConnect();
    _dbConnectUser.dbConnect();
    _dbConnectShiftType.dbConnect();
    // _authShredPrefs.init();
    super.initState();
  }

  @override
  getExtra() {}

  @override
  Widget screenBody(BuildContext context) {
    //load the all vacancies of all the nations as stream
    return StreamBuilder<List<VacantShift>>(
        stream: _dbConnect.getVacancies(),
        builder: (context, snapshotVacantShifts) {
          if (snapshotVacantShifts.connectionState == ConnectionState.active) {
            var vacantShiftsList = snapshotVacantShifts.data;
            if (vacantShiftsList != null && vacantShiftsList.isNotEmpty) {

              var njcUserCredentials = _authShredPrefs.retrieveSavedUserCredentials();
              if (njcUserCredentials!=null && njcUserCredentials.user != null) {
                var njcUser = njcUserCredentials.user;

                
                return StreamBuilder<List<MyApplication>>(
                  stream: _dbConnectMyShifts.getMyShifts(njcUser!.id!),
                  builder: (context, snapshotMyShifts) {
                    if (snapshotMyShifts.connectionState == ConnectionState.active) {
                      var myShiftsList = snapshotMyShifts.data;
                        if (myShiftsList != null) {
                          for (var myShift in myShiftsList) {
                            vacantShiftsList.removeWhere((vacantShift) => vacantShift.id == myShift.vacancyId);
                          }
                        }
                            //Show list view of the vacant shifts...
                            return ListView.builder(
                              itemCount: vacantShiftsList.length,
                              //Load the nation details using nation's id...
                              itemBuilder: (ctx, i) => FutureBuilder(
                                    future: _dbConnectNation
                                        .readNationsList(vacantShiftsList[i].nation),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Nation> snapshot) {
                                      var nation = snapshot.data;
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        //Load the shift types list.......
                                        return FutureBuilder(
                                          future: _dbConnectShiftType
                                              .readShiftType(vacantShiftsList[i].shiftType),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<ShiftType> snapshotShiftType) {
                                            if (snapshotShiftType.connectionState ==
                                                ConnectionState.done) {
                                              var shiftType = snapshotShiftType.data;
                                              return ShiftDetailsCard(
                                                nation: nation,
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return ApplyDialog("Confirmation",
                                                            "Do you need to apply for this shift?",
                                                            onApply: () {
                                                              var njcUserCredentials = _authShredPrefs.retrieveSavedUserCredentials();
                                                              if (njcUserCredentials != null &&
                                                                      njcUserCredentials.user != null) {
                                                                var user = njcUserCredentials.user;
                                                                    _dbConnectApplication
                                                                        .sendApplication(Application(
                                                                            vacantShiftsList[i]
                                                                                .id,
                                                                            nation!,
                                                                            shiftType!,
                                                                            vacantShiftsList[i]
                                                                                .endTime,
                                                                            vacantShiftsList[i]
                                                                                .wage,
                                                                            vacantShiftsList[i]
                                                                                .time,
                                                                            user!.id!,
                                                                            user.name!,
                                                                            user.fbProfile!));
                                                                  } else {
                                                                    Navigator.push(context,
                                                                      MaterialPageRoute(builder: (context) =>  
                                                                      SigninScreen(onSigninSuccess: (userCredentials){
                                                                        _dbConnectApplication
                                                                        .sendApplication(Application(
                                                                            vacantShiftsList[i]
                                                                                .id,
                                                                            nation!,
                                                                            shiftType!,
                                                                            vacantShiftsList[i]
                                                                                .endTime,
                                                                            vacantShiftsList[i]
                                                                                .wage,
                                                                            vacantShiftsList[i]
                                                                                .time,
                                                                            userCredentials.user!.id!,
                                                                            userCredentials.user!.name!,
                                                                            userCredentials.user!.fbProfile!));
                                                                      },)));
                                                                    
                                                                  }
                                                        });
                                                      });
                                                },
                                                vacantShift: vacantShiftsList[i],
                                                shiftType: shiftType,
                                              );
                                            } else {
                                              return const NoData(
                                                  "No vacant shifts available");
                                            }
                                          },
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Waiting();
                                      } else {
                                        return const NoData("No vacant shifts available");
                                      }
                                    },
                                  ));
                        }else if(snapshotMyShifts.connectionState ==
                              ConnectionState.waiting){
                                return const Waiting();
                        }else{
                          return const NoData("No vacant shifts available");
                        }
                    });
              }else{
                return const NoData("No vacant shifts available");
              }
            
              
            } else {
              return const NoData("No vacant shifts available");
            }
          } else if (snapshotVacantShifts.connectionState ==
              ConnectionState.waiting) {
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
