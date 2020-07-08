import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';

class VisitsView extends StatefulWidget {
  var _visitsPresenter;

  VisitsView(VisitsPresenter visitsPresenter) {
    _visitsPresenter = visitsPresenter;
  }

  @override
  State<StatefulWidget> createState() => _VisitsViewState(_visitsPresenter);
}

class _VisitsViewState extends State<VisitsView> {
  var _visitsPresenter;

  _VisitsViewState(this._visitsPresenter);

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
                    _visitsPresenter.goBack(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: _visitsPresenter
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
              "Отметьте посещения",
              style: TextStyle(
                  color: _visitsPresenter
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
                        isEqualTo: _visitsPresenter.mainPresenter
                            .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId)
                    .orderBy("lastname")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return Card(
                            color: _visitsPresenter
                                .mainPresenter.mainPresenterModel.themeColorEnd,
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('Visits')
                                    .where("student_id",
                                        isEqualTo: snapshot
                                            .data.documents[index].documentID)
                                    .where("lesson_id",
                                        isEqualTo: _visitsPresenter
                                            .visitsModel.lessonId)
                                    .snapshots(),
                                builder: (context, futureSnapshot) {
                                  if (futureSnapshot.hasData) {
                                    return CheckboxListTile(
                                      title: Text(
                                        "${snapshot.data.documents[index]["lastname"]} ${snapshot.data.documents[index]["name"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                      value: futureSnapshot.data.documents[0]
                                          ["last_visit"],
                                      onChanged: (bool value) {
                                        setState(() {
                                          _visitsPresenter.visitsModel
                                              .markStudentVisit(
                                                  snapshot.data.documents[index]
                                                      .documentID,
                                                  _visitsPresenter
                                                      .visitsModel.lessonId,
                                                  value);
                                        });
                                      },
                                      activeColor: Colors.white,
                                      checkColor: _visitsPresenter.mainPresenter
                                          .mainPresenterModel.themeColorEnd,
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                }));
                      });
                }),
            flex: 9)
      ],
    ));
  }
}
