import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/entities/Group.dart';
import 'package:flutterapp/Catalog/Groups/presenter/GroupsPresenter.dart';
import 'package:flutterapp/Statistics/presenter/StatisticsPresenter.dart';

class StatisticsView extends StatefulWidget {
  var _statisticsPresenter;

  StatisticsView(this._statisticsPresenter);

  @override
  State<StatefulWidget> createState() =>
      _StatisticsViewState(_statisticsPresenter);
}

class _StatisticsViewState extends State<StatisticsView> {
  var _statisticsPresenter;
  List<Group> _groups;

  _StatisticsViewState(StatisticsPresenter _statisticsPresenter) {
    this._statisticsPresenter = _statisticsPresenter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGridView(context),
    );
  }

  Widget buildGridView(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Container(
            child: Center(
          child: Text(
            "Статистика по группам:",
            style: TextStyle(
                color: _statisticsPresenter
                    .mainPresenter.mainPresenterModel.themeColorEnd,
                fontSize: 25),
          ),
        )),
        flex: 5,
      ),
      Expanded(
        child: Container(
            padding: EdgeInsets.only(top: 5),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("Groups")
                  .orderBy("group_name")
                  .snapshots(),
              builder: (context, snapshotOfGroups) {
                if (!snapshotOfGroups.hasData) return const Text('Loading...');
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: snapshotOfGroups.data.documents.length,
                    itemBuilder: (_, index) {
                      return Center(
                          child: GestureDetector(
                              onTap: () {
                                _statisticsPresenter
                                        .mainPresenter
                                        .statisticsStudentPresenter
                                        .statisticsStudentModel
                                        .groupId =
                                    snapshotOfGroups
                                        .data.documents[index].documentID;
                                _statisticsPresenter
                                        .mainPresenter
                                        .statisticsStudentPresenter
                                        .statisticsStudentModel
                                        .groupTitle =
                                    snapshotOfGroups.data.documents[index]
                                        ["group_name"];
                                _statisticsPresenter
                                    .goToStatisticsStudent(context);
                              },
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                      color: _statisticsPresenter.mainPresenter
                                          .mainPresenterModel.themeColorEnd,
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            "${snapshotOfGroups.data.documents[index]["group_name"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                              child: FutureBuilder(
                                            future: _statisticsPresenter
                                                .statisticsModel
                                                .getAverageAttandance(
                                                    snapshotOfGroups
                                                        .data
                                                        .documents[index]
                                                        .documentID),
                                            builder:
                                                (context, studentsSnapshot) {
                                              if (!studentsSnapshot.hasData) {
                                                return Text("Loading...");
                                              }
                                              return FutureBuilder(
                                                future: _statisticsPresenter
                                                    .statisticsModel
                                                    .getGroupVisits(
                                                        snapshotOfGroups
                                                            .data
                                                            .documents[index]
                                                            .documentID),
                                                builder:
                                                    (context, groupSnapshot) {
                                                  if (!groupSnapshot.hasData) {
                                                    return Text(
                                                      "Loading...",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    "${((groupSnapshot.data == 0) ? 0 : studentsSnapshot.data / groupSnapshot.data * 100).toInt()} %",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          )),
                                        ],
                                      ))))));
                    });
              },
            )),
        flex: 25,
      )
    ]);
  }

  void addGroup(String groupId, String groupTitle) {
    setState(() {
      _groups.add(Group(groupId, groupTitle));
    });
  }
}
