import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSkillWidget extends StatefulWidget {
  AddSkillWidget({Key key}) : super(key: key);

  @override
  _AddSkillWidgetState createState() => _AddSkillWidgetState();
}

class _AddSkillWidgetState extends State<AddSkillWidget>
    with TickerProviderStateMixin {
  SkillsRecord newSkill;
  String dropDown1Value;
  String dropDown2Value;
  final animationsMap = {
    'dropDownOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 40,
      fadeIn: true,
      slideOffset: Offset(0, -20),
    ),
  };

  @override
  void initState() {
    super.initState();
    startAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.darkBackground,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 3,
                indent: 150,
                endIndent: 150,
                color: Color(0xFF465056),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text(
                  'Add skill',
                  style: FlutterFlowTheme.title3.override(
                    fontFamily: 'Lexend Deca',
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Text(
                          'Choose Sport',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: FlutterFlowDropDown(
                      options: [
                        'Basketall',
                        'Football',
                        'Voley',
                        'Cyclism',
                        'Golf',
                        'Running',
                        'Yoga'
                      ].toList(),
                      onChanged: (value) {
                        setState(() => dropDown1Value = value);
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.textColor,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.grayLight,
                        size: 15,
                      ),
                      fillColor: FlutterFlowTheme.darkBackground,
                      elevation: 3,
                      borderColor: FlutterFlowTheme.background,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsets.fromLTRB(20, 4, 16, 4),
                      hidesUnderline: true,
                    ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Text(
                          'Choose Level',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: FlutterFlowDropDown(
                      options: [
                        'Begginer',
                        'Amateur',
                        'Prodigy',
                        'Professional'
                      ].toList(),
                      onChanged: (value) {
                        setState(() => dropDown2Value = value);
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.textColor,
                      ),
                      fillColor: FlutterFlowTheme.darkBackground,
                      elevation: 3,
                      borderColor: FlutterFlowTheme.background,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsets.fromLTRB(20, 4, 16, 4),
                      hidesUnderline: true,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      options: FFButtonOptions(
                        width: 100,
                        height: 50,
                        color: FlutterFlowTheme.background,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        final skillsCreateData = createSkillsRecordData(
                          sport: dropDown1Value,
                          level: dropDown2Value,
                        );
                        final skillsRecordReference =
                            SkillsRecord.collection.doc();
                        await skillsRecordReference.set(skillsCreateData);
                        newSkill = SkillsRecord.getDocumentFromData(
                            skillsCreateData, skillsRecordReference);

                        final usersUpdateData = {
                          'skills': FieldValue.arrayUnion([newSkill.reference]),
                        };
                        await currentUserReference.update(usersUpdateData);
                        Navigator.pop(context);

                        setState(() {});
                      },
                      text: 'Save Changes',
                      options: FFButtonOptions(
                        width: 150,
                        height: 50,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
