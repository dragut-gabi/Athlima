import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/create_event_widget.dart';
import '../event_details/event_details_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventsWidget extends StatefulWidget {
  MyEventsWidget({Key key}) : super(key: key);

  @override
  _MyEventsWidgetState createState() => _MyEventsWidgetState();
}

class _MyEventsWidgetState extends State<MyEventsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.background,
        automaticallyImplyLeading: false,
        title: Text(
          'Events',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Lexend Deca',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                height: 720,
                child: CreateEventWidget(
                  userProfile: currentUserReference,
                ),
              );
            },
          );
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          color: FlutterFlowTheme.textColor,
          size: 36,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelColor: FlutterFlowTheme.primaryColor,
                      indicatorColor: FlutterFlowTheme.secondaryColor,
                      tabs: [
                        Tab(
                          text: 'All events',
                        ),
                        Tab(
                          text: 'My events',
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          StreamBuilder<List<EventsRecord>>(
                            stream: queryEventsRecord(
                              queryBuilder: (eventsRecord) => eventsRecord
                                  .where('people',
                                      arrayContains: currentUserReference)
                                  .orderBy('dateTime'),
                            ),
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
                              List<EventsRecord> listViewEventsRecordList =
                                  snapshot.data;
                              if (listViewEventsRecordList.isEmpty) {
                                return Center(
                                  child: Image.asset(
                                    'assets/images/noAppointments.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewEventsRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewEventsRecord =
                                      listViewEventsRecordList[listViewIndex];
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
                                    child: StreamBuilder<EventsRecord>(
                                      stream: EventsRecord.getDocument(
                                          listViewEventsRecord.reference),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: SpinKitPumpingHeart(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                size: 40,
                                              ),
                                            ),
                                          );
                                        }
                                        final appointmentCardEventsRecord =
                                            snapshot.data;
                                        return InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EventDetailsWidget(
                                                  eventDetails:
                                                      appointmentCardEventsRecord
                                                          .reference,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .darkBackground,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    12, 12, 12, 12),
                                                child:
                                                    StreamBuilder<SkillsRecord>(
                                                  stream: SkillsRecord.getDocument(
                                                      appointmentCardEventsRecord
                                                          .skill),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child:
                                                              SpinKitPumpingHeart(
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final paddingSkillsRecord =
                                                        snapshot.data;
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          4,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    listViewEventsRecord
                                                                        .name,
                                                                    style: FlutterFlowTheme
                                                                        .title3
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .chevron_right_rounded,
                                                                color: FlutterFlowTheme
                                                                    .grayLight,
                                                                size: 24,
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 8, 0, 0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Card(
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  color: FlutterFlowTheme
                                                                      .background,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            8,
                                                                            4,
                                                                            8,
                                                                            4),
                                                                    child: Text(
                                                                      dateTimeFormat(
                                                                          'd/M H:m',
                                                                          listViewEventsRecord
                                                                              .dateTime),
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .textColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              8,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'For',
                                                                        style: FlutterFlowTheme
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily:
                                                                              'Lexend Deca',
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      paddingSkillsRecord
                                                                          .sport,
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .secondaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      paddingSkillsRecord
                                                                          .level,
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .secondaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
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
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          StreamBuilder<List<EventsRecord>>(
                            stream: queryEventsRecord(
                              queryBuilder: (eventsRecord) => eventsRecord
                                  .where('owner',
                                      isEqualTo: currentUserReference)
                                  .orderBy('dateTime'),
                            ),
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
                              List<EventsRecord> listViewEventsRecordList =
                                  snapshot.data;
                              if (listViewEventsRecordList.isEmpty) {
                                return Center(
                                  child: Image.asset(
                                    'assets/images/noAppointments.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewEventsRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewEventsRecord =
                                      listViewEventsRecordList[listViewIndex];
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                                    child: StreamBuilder<EventsRecord>(
                                      stream: EventsRecord.getDocument(
                                          listViewEventsRecord.reference),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: SpinKitPumpingHeart(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                size: 40,
                                              ),
                                            ),
                                          );
                                        }
                                        final appointmentCardEventsRecord =
                                            snapshot.data;
                                        return InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EventDetailsWidget(
                                                  eventDetails:
                                                      appointmentCardEventsRecord
                                                          .reference,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .darkBackground,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    12, 12, 12, 12),
                                                child:
                                                    StreamBuilder<SkillsRecord>(
                                                  stream: SkillsRecord.getDocument(
                                                      appointmentCardEventsRecord
                                                          .skill),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child:
                                                              SpinKitPumpingHeart(
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final paddingSkillsRecord =
                                                        snapshot.data;
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          4,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    listViewEventsRecord
                                                                        .name,
                                                                    style: FlutterFlowTheme
                                                                        .title3
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .chevron_right_rounded,
                                                                color: FlutterFlowTheme
                                                                    .grayLight,
                                                                size: 24,
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 8, 0, 0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Card(
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  color: FlutterFlowTheme
                                                                      .background,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            8,
                                                                            4,
                                                                            8,
                                                                            4),
                                                                    child: Text(
                                                                      dateTimeFormat(
                                                                          'd/M H:m',
                                                                          listViewEventsRecord
                                                                              .dateTime),
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .textColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              8,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'For',
                                                                        style: FlutterFlowTheme
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily:
                                                                              'Lexend Deca',
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      paddingSkillsRecord
                                                                          .sport,
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .secondaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      paddingSkillsRecord
                                                                          .level,
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .secondaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
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
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
