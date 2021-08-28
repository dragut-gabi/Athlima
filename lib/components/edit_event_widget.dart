import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditEventWidget extends StatefulWidget {
  EditEventWidget({
    Key key,
    this.event,
  }) : super(key: key);

  final DocumentReference event;

  @override
  _EditEventWidgetState createState() => _EditEventWidgetState();
}

class _EditEventWidgetState extends State<EditEventWidget>
    with TickerProviderStateMixin {
  DateTime datePicked;
  String dropDown1Value;
  String dropDown2Value;
  TextEditingController eventNameController;
  TextEditingController problemDescriptionController;
  var placePickerValue = FFPlace();
  String uploadedFileUrl = '';
  final animationsMap = {
    'textFieldOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      slideOffset: Offset(0, -9),
    ),
    'dropDownOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 40,
      fadeIn: true,
      slideOffset: Offset(0, -20),
    ),
    'textFieldOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 60,
      fadeIn: true,
      slideOffset: Offset(0, -30),
    ),
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      slideOffset: Offset(0, -90),
    ),
    'buttonOnPageLoadAnimation1': AnimationInfo(
      curve: Curves.bounceOut,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 150,
      fadeIn: true,
      slideOffset: Offset(0, -20),
    ),
    'buttonOnPageLoadAnimation2': AnimationInfo(
      curve: Curves.bounceOut,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 150,
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
    return StreamBuilder<EventsRecord>(
      stream: EventsRecord.getDocument(widget.event),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: SpinKitPumpingHeart(
                color: FlutterFlowTheme.primaryColor,
                size: 40,
              ),
            ),
          );
        }
        final containerEventsRecord = snapshot.data;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.darkBackground,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: StreamBuilder<UsersRecord>(
              stream: UsersRecord.getDocument(currentUserReference),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: SpinKitPumpingHeart(
                        color: FlutterFlowTheme.primaryColor,
                        size: 40,
                      ),
                    ),
                  );
                }
                final columnUsersRecord = snapshot.data;
                return SingleChildScrollView(
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
                          'Edit Event',
                          style: FlutterFlowTheme.title3.override(
                            fontFamily: 'Lexend Deca',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: eventNameController ??=
                              TextEditingController(
                            text: containerEventsRecord.name,
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Event name',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.background,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.background,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.darkBackground,
                            contentPadding: EdgeInsets.fromLTRB(20, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: FlutterFlowTheme.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animated(
                            [animationsMap['textFieldOnPageLoadAnimation1']]),
                      ),
                      StreamBuilder<SkillsRecord>(
                        stream: SkillsRecord.getDocument(
                            containerEventsRecord.skill),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: SpinKitPumpingHeart(
                                  color: FlutterFlowTheme.primaryColor,
                                  size: 40,
                                ),
                              ),
                            );
                          }
                          final columnSkillsRecord = snapshot.data;
                          return Column(
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
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
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
                                  initialOption: columnSkillsRecord.sport,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 60,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
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
                                ).animated([
                                  animationsMap['dropDownOnPageLoadAnimation']
                                ]),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                    child: Text(
                                      'Choose Level',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
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
                                  initialOption: columnSkillsRecord.level,
                                  options: [
                                    'Begginer',
                                    'Amateur',
                                    'Prodigy',
                                    'Professional'
                                  ].toList(),
                                  onChanged: (value) {
                                    setState(() => dropDown2Value = value);
                                  },
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 60,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
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
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: problemDescriptionController ??=
                              TextEditingController(
                            text: containerEventsRecord.description,
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.background,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.background,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.darkBackground,
                            contentPadding: EdgeInsets.fromLTRB(20, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: FlutterFlowTheme.textColor,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                        ).animated(
                            [animationsMap['textFieldOnPageLoadAnimation2']]),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            await DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (date) {
                                setState(() => datePicked = date);
                              },
                              currentTime: DateTime.now(),
                              minTime: DateTime.now(),
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.darkBackground,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: FlutterFlowTheme.background,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            'Choose Date',
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 4, 0, 0),
                                          child: Text(
                                            dateTimeFormat(
                                                'M/d H:m', datePicked),
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            print('IconButton pressed ...');
                                          },
                                          icon: Icon(
                                            Icons.date_range_outlined,
                                            color: FlutterFlowTheme.grayLight,
                                            size: 20,
                                          ),
                                          iconSize: 20,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ).animated(
                            [animationsMap['containerOnPageLoadAnimation']]),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 16, 0, 0),
                        child: FlutterFlowPlacePicker(
                          iOSGoogleMapsApiKey:
                              'AIzaSyBDu5h-kjIZXdzIBRLREEkGc68EN_hqXiE',
                          androidGoogleMapsApiKey:
                              'AIzaSyA1hlSfjC7q3GczIUzWOYJbHdM9yBkw84A',
                          webGoogleMapsApiKey:
                              'AIzaSyD6qj1It71hKsugKf_qkFLn7cEWbsXbzQI',
                          onSelect: (place) =>
                              setState(() => placePickerValue = place),
                          defaultText: 'Select Location',
                          icon: Icon(
                            Icons.place,
                            color: Colors.white,
                            size: 16,
                          ),
                          buttonOptions: FFButtonOptions(
                            width: 200,
                            height: 40,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Image.network(
                                valueOrDefault<String>(
                                  uploadedFileUrl,
                                  'data:image/png;base64,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',
                                ),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                  );
                                  if (selectedMedia != null &&
                                      validateFileFormat(
                                          selectedMedia.storagePath, context)) {
                                    showUploadMessage(
                                        context, 'Uploading file...',
                                        showLoading: true);
                                    final downloadUrl = await uploadData(
                                        selectedMedia.storagePath,
                                        selectedMedia.bytes);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (downloadUrl != null) {
                                      setState(
                                          () => uploadedFileUrl = downloadUrl);
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      showUploadMessage(
                                          context, 'Failed to upload media');
                                      return;
                                    }
                                  }
                                },
                                text: 'Change Photo',
                                options: FFButtonOptions(
                                  width: 140,
                                  height: 40,
                                  color: FlutterFlowTheme.darkBackground,
                                  textStyle:
                                      FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            )
                          ],
                        ),
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
                            ).animated(
                                [animationsMap['buttonOnPageLoadAnimation1']]),
                            StreamBuilder<SkillsRecord>(
                              stream: SkillsRecord.getDocument(
                                  containerEventsRecord.skill),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: SpinKitPumpingHeart(
                                        color: FlutterFlowTheme.primaryColor,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                }
                                final buttonSkillsRecord = snapshot.data;
                                return FFButtonWidget(
                                  onPressed: () async {
                                    final skillsUpdateData =
                                        createSkillsRecordData(
                                      sport: skillEvent.sport,
                                      level: skillEvent.level,
                                    );
                                    await buttonSkillsRecord.reference
                                        .update(skillsUpdateData);

                                    final eventsUpdateData =
                                        createEventsRecordData(
                                      name: eventNameController?.text ?? '',
                                      description:
                                          problemDescriptionController?.text ??
                                              '',
                                      location: placePickerValue.latLng,
                                      dateTime: datePicked,
                                      picture: uploadedFileUrl,
                                    );
                                    await containerEventsRecord.reference
                                        .update(eventsUpdateData);
                                    Navigator.pop(context);

                                    setState(() {});
                                  },
                                  text: 'Save',
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 50,
                                    color: FlutterFlowTheme.primaryColor,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
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
                                ).animated([
                                  animationsMap['buttonOnPageLoadAnimation2']
                                ]);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
