import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/StatisticsStudent/presenter/StatisticsStudentPresenter.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';

class StatisticsStudentView extends StatefulWidget {
  var _statisticsStudentPresenter;

  StatisticsStudentView(StatisticsStudentPresenter statisticsStudentPresenter) {
    _statisticsStudentPresenter = statisticsStudentPresenter;
  }

  @override
  State<StatefulWidget> createState() =>
      _StatisticsStudentViewState(_statisticsStudentPresenter);
}

class _StatisticsStudentViewState extends State<StatisticsStudentView> {
  var _statisticsStudentPresenter;

  _StatisticsStudentViewState(this._statisticsStudentPresenter);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: IconButton(
                  onPressed: () {
                    _statisticsStudentPresenter.goBack(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: _statisticsStudentPresenter
                        .mainPresenter.mainPresenterModel.themeColorEnd,
                  ),
                  iconSize: 40.0,
                ),
              ),
            ],
          ),
          flex: 2,
        ),
        Expanded(
          child: Center(
            child: Text(
              "Группа ${_statisticsStudentPresenter.statisticsStudentModel.groupTitle}",
              style: TextStyle(
                  color: _statisticsStudentPresenter
                      .mainPresenter.mainPresenterModel.themeColorEnd,
                  fontSize: 20),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Center(
            child: Text(
              "Статистика по студентам",
              style: TextStyle(
                  color: _statisticsStudentPresenter
                      .mainPresenter.mainPresenterModel.themeColorEnd,
                  fontSize: 20),
            ),
          ),
          flex: 1,
        ),
        Expanded(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection("Students")
                    .where("group_id",
                        isEqualTo: _statisticsStudentPresenter
                            .statisticsStudentModel.groupId)
                    .orderBy("lastname")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return Container(
                            height: 50,
                            child: Card(
                                color: _statisticsStudentPresenter.mainPresenter
                                    .mainPresenterModel.themeColorEnd,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                          "${snapshot.data.documents[index]["lastname"]} ${snapshot.data.documents[index]["name"]}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: FutureBuilder(
                                        future: _statisticsStudentPresenter
                                            .statisticsStudentModel
                                            .getGroupVisits(
                                                _statisticsStudentPresenter
                                                    .statisticsStudentModel
                                                    .groupId),
                                        builder: (context, groupSnapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("Loading...",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20));
                                          }
                                          return FutureBuilder(
                                            future: _statisticsStudentPresenter
                                                .statisticsStudentModel
                                                .getStudentVisits(snapshot
                                                    .data
                                                    .documents[index]
                                                    .documentID),
                                            builder:
                                                (context, studentSnapshot) {
                                              if (!studentSnapshot.hasData) {
                                                return Text("Loading");
                                              }
                                              return Text(
                                                  "${(studentSnapshot.data / groupSnapshot.data * 100).toInt()} %",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20));
                                            },
                                          );
                                        },
                                      ),
                                      flex: 1,
                                    )
                                  ],
                                )));
                      });
                }),
            flex: 9)
      ],
    ));
  }
}
