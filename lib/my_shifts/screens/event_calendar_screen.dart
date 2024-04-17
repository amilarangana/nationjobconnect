import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:nation_job_connect/authentication/models/user_credentials.dart';
import 'package:nation_job_connect/authentication/store_credentials/auth_shared_prefs.dart';
import '../../firebase/firestore_application.dart';
import '../../firebase/firestore_my_shifts.dart';
import '../../widgets/common/no_data.dart';
import '../../widgets/common/waiting.dart';
import '../models/my_application.dart';
import '../widgets/decline_dialog.dart';
import '../widgets/info_dialog.dart';
import '../widgets/my_shift_details_card.dart';
import '/firebase/firestore_user.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';

class EventCalendarScreen extends BaseScreen {
  static const routeName = '/event_calendar_screen';
  
  EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends BaseState<EventCalendarScreen> with BasicScreen {

final _dbConnectMyShifts = FirestoreMyShifts();
  final _dbConnectUser = FirestoreUser();
  final _dbConnectApplication = FirestoreApplication();
  final _authShredPrefs = AuthSharedPrefs();

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
    var savedUserCredentials = _authShredPrefs.retrieveSavedUserCredentials();
    if (savedUserCredentials!=null && savedUserCredentials.user != null) {
      var njcUser = savedUserCredentials.user;

      return StreamBuilder<List<MyApplication>>(
              stream: _dbConnectMyShifts.getMyShifts(njcUser!.id!),
                        builder: (context, snapshotMyShifts) {
                          if (snapshotMyShifts.connectionState == ConnectionState.active) {
                            var myShiftsList = snapshotMyShifts.data;
                            
                             if (myShiftsList != null && myShiftsList.isNotEmpty) {
                              var eventList = <Event>[];
                                for (var i = 0; i < myShiftsList.length; i++) {
                                  eventList.add(
                                    Event(
                                      child: MyShiftDetailsCard(
                                        nation: myShiftsList[i].nation, 
                                        onTap: (){
                                          if (myShiftsList[i].status == 1) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const InfoDialog("Info",
                                                    "You can not decline the approved shifts here. Please contact nation's admin.",
                                                  );
                                              });
                                          }else{
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DeclineDialog("Confirmation",
                                                    "Do you need to decline this application?",
                                                    onDecline: () {
                                                  _dbConnectApplication
                                                      .removeApplication(
                                                          njcUser.id!,
                                                          myShiftsList[i].vacancyId,
                                                          myShiftsList[i].id);
                                                });
                                              });
                                          }
                                        }, 
                                        myApplication: myShiftsList[i], 
                                        shiftType: myShiftsList[i].shiftType), 
                                      dateTime: CalendarDateTime(
                                        year: myShiftsList[i].time.year,
                                        month: myShiftsList[i].time.month,
                                        day: myShiftsList[i].time.day,
                                        calendarType: CalendarType.GREGORIAN,
                                      ),
                                    )
                                  );
                                  }

                                  return Center(
                                    child: EventCalendar(
                                      calendarType: CalendarType.GREGORIAN,
                                      calendarLanguage: 'en',
                                      calendarOptions: CalendarOptions(
                                        headerMonthBackColor: Colors.white
                                      ),
                                      events: eventList
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
      return const NoData("No My shifts available");
    }
  
    
  }
  
  @override
  String screenName() {
    return "My Calendar";
  }
}

typedef OnSigninSuccess = void Function(UserCredentials userCredentials);