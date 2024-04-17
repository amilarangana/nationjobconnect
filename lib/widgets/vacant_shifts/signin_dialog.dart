import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/resources/strings.dart';
import '../../firebase/firestore_nation.dart';
import '/resources/colors.dart';
import '/resources/dimensions.dart';
import '/resources/utils.dart';
import '/widgets/common/subtitle_text.dart';
import '/widgets/common/transparent_button.dart';

class SigninDialog extends StatefulWidget {
  final ValidateListener onValidate;
  String? fbProfile;
  String? nationMembershipNo;
  String? nationId;
  bool isCurrentMember;
  SigninDialog({super.key, this.fbProfile, this.nationMembershipNo, this.nationId, 
  required this.isCurrentMember ,required this.onValidate});

  @override
  _SigninDialogState createState() => _SigninDialogState();
}

class _SigninDialogState extends State<SigninDialog> {
  final _loginFormKey = GlobalKey<FormState>();
  final _dbConnectNation = FirestoreNation();
  
  var nationMemberNoTextController = TextEditingController();
  var fbProfileTextController = TextEditingController();
  bool isNationMember = false;
  Nation? selectedNation;

  @override
  void initState() {
    _dbConnectNation.dbConnect();
    isNationMember = widget.isCurrentMember;
    fbProfileTextController.text = widget.fbProfile ?? "";
    nationMemberNoTextController.text = widget.nationMembershipNo ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
            backgroundColor: const Color(ResColors.colorPrimaryDark),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(
                    width: 2.0,
                    style: BorderStyle.solid,
                    color: Color(ResColors.colorFontSplash))),
            child: Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 2,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SubTitleText("Enter your details"),
                        TextFormField(
                          controller: fbProfileTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "FB Profile can not be empty";
                            }
                            return null;
                          },
                          obscureText: false,
                          style: const TextStyle(
                              color: Color(ResColors.colorFontSplash),
                              fontSize: ResDimensions.fontSizeDataEntry),
                          decoration:
                              Utils.getInputDecoration("FB Profile", null),
                          cursorColor: const Color(ResColors.colorFontSplash),
                        ),
                        Row(
                          children: [
                            Checkbox(value: isNationMember, semanticLabel: Strings.stringNationMemberhsip, onChanged: (bool? newValue) {
                              setState(() {
                                 newValue != null ? isNationMember = newValue: isNationMember = false;
                              });
                            }),
                            const Text(Strings.stringNationMemberhsip, style: TextStyle(color: Color(ResColors.colorFontSplash)))
                          ],
                        ),
                        Visibility(
                          visible: isNationMember,
                          child: TextFormField(
                            controller: nationMemberNoTextController,
                            validator: (value) {
                              return null;
                            },
                            obscureText: false,
                            style: const TextStyle(
                                color: Color(ResColors.colorFontSplash),
                                fontSize: ResDimensions.fontSizeDataEntry),
                            decoration:
                                Utils.getInputDecoration("Nation Membership No", null),
                            cursorColor: const Color(ResColors.colorFontSplash),
                          ),
                        ),
                        FutureBuilder(
                          future: _dbConnectNation.getNationsList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Container(
                                width: double.infinity,
                                // margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: Utils.getTextViewDecoration(),
                                child: DropdownButtonFormField<Nation>(
                                  value: selectedNation ?? (snapshot.data as List<Nation>).where((nation) => nation.id == widget.nationId).first,
                                  style: const TextStyle(
                                      color: Color(ResColors.colorFontSplash),
                                      fontSize: ResDimensions.fontSizeDataEntry),
                                  dropdownColor:
                                      const Color(ResColors.colorPrimary),
                                  iconEnabledColor:
                                      const Color(ResColors.colorFontSplash),
                                  items: getItemsList(snapshot.data),
                                  onChanged: (value) {
                                    selectedNation = value;
                                  },
                                  hint: const Text(
                                    "Select your Nation",
                                    style: TextStyle(
                                        color: Color(ResColors.colorFontSplash),
                                        fontSize: ResDimensions.fontSizeDataEntry),
                                  ),
                                ),
                              );
                            } else {
                              return const Text("No Data");
                            }
                          },
                        ),
                        TransparentButton(
                          "Apply",
                          () {
                            if (_loginFormKey.currentState!.validate()) {
                              widget.onValidate(
                                  fbProfileTextController.text.trim(), nationMemberNoTextController.text.trim(), selectedNation?.id);
                            }
                          },
                        ),
                      ],
                    )))));
  }

  List<DropdownMenuItem<Nation>> getItemsList(List<Nation> shiftList) {
    List<DropdownMenuItem<Nation>> dropDownMenuItemList = [];
    for (var value in shiftList) {
      dropDownMenuItemList.add(DropdownMenuItem(
          key: UniqueKey(),
          value: value,
          child: Container(
              alignment: Alignment.centerLeft,
              // width: MediaQuery.of(context).size.width / 4 * 3,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: Utils.getContainerDecoration(),
              child: Text(value.name))));
    }

    return dropDownMenuItemList;
  }
}

typedef ValidateListener = void Function(String fbProfile, String? nationMembershipNo, String? nationId);
