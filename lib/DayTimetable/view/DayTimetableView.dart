import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/DayTimetable/entities/Subject.dart';
import 'package:flutterapp/DayTimetable/presenter/DayTimetablePresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class DayTimetableView extends StatefulWidget {
  var _dayTimetablePresenter;

  DayTimetableView(DayTimetablePresenter dayTimetablePresenter) {
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  State<StatefulWidget> createState() =>
      DayTimetableViewState(_dayTimetablePresenter);
}

class DayTimetableViewState extends State<DayTimetableView> {
  var _dayTimetablePresenter;
  TextEditingController _titleController;
  TextEditingController _teacherLastName;
  TextEditingController _teacherName;
  TextEditingController _textBook;
  TextEditingController _textBookRef;
  TextEditingController _description;
  TextEditingController _homework;
  TextEditingController _zoomRef;

  DayTimetableViewState(DayTimetablePresenter dayTimetablePresenter) {
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _teacherName = TextEditingController();
    _teacherLastName = TextEditingController();
    _textBook = TextEditingController();
    _textBookRef = TextEditingController();
    _description = TextEditingController();
    _homework = TextEditingController();
    _zoomRef = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _teacherName.dispose();
    _teacherLastName.dispose();
    _textBook.dispose();
    _textBookRef.dispose();
    _description.dispose();
    _homework.dispose();
    _zoomRef.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_dayTimetablePresenter.mainPresenter.catalogPresenter.state) {
      case "Teacher":
        return Scaffold(
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection("Lessons")
                    .where("group_id",
                        isEqualTo: _dayTimetablePresenter.mainPresenter
                            .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId)
                    .where("day_of_week",
                        isEqualTo:
                            "${_dayTimetablePresenter.dayTimetableModel.dayOfTheWeek}")
                    .snapshots(),
                builder: (context, snapshotOfLesson) {
                  if (!snapshotOfLesson.hasData)
                    return Center(
                      child: Text("Loading..."),
                    );
                  return Column(
                    children: <Widget>[
                      new Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  _dayTimetablePresenter.goBack(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: _dayTimetablePresenter.mainPresenter
                                      .mainPresenterModel.themeColorEnd,
                                ),
                                iconSize: 40.0,
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  iconSize: 40.0,
                                  icon: Icon(
                                    EgeHelper.plus,
                                    color: _dayTimetablePresenter.mainPresenter
                                        .mainPresenterModel.themeColorEnd,
                                  ),
                                  onPressed: () {
                                    _showMyDialog(
                                        snapshotOfLesson.data.documents.length);
                                  },
                                ))
                          ],
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "${_dayTimetablePresenter.dayTimetableModel.dayOfTheWeek}",
                            style: TextStyle(
                                color: _dayTimetablePresenter.mainPresenter
                                    .mainPresenterModel.themeColorEnd,
                                fontSize: 20),
                          ),
                        ),
                        flex: 1,
                      ),
                      new Expanded(
                        child: ListView.builder(
                            itemCount: snapshotOfLesson.data.documents.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                  onTap: () {
                                    _dayTimetablePresenter
                                            .mainPresenter
                                            .visitsPresenter
                                            .visitsModel
                                            .lessonId =
                                        snapshotOfLesson
                                            .data.documents[index].documentID;
                                    _dayTimetablePresenter.goToVisits(context);
                                  },
                                  child: Card(
                                    color: Colors.white70,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          snapshotOfLesson.data.documents[index]
                                              ["title"],
                                          style: TextStyle(
                                              color: _dayTimetablePresenter
                                                  .mainPresenter
                                                  .mainPresenterModel
                                                  .themeColorEnd,
                                              fontSize: 20),
                                        ),
                                        StreamBuilder(
                                          stream: Firestore.instance
                                              .collection("Teachers")
                                              .document(snapshotOfLesson
                                                      .data.documents[index]
                                                  ["teacher_id"])
                                              .snapshots(),
                                          builder:
                                              (context, snapshotOfTeacher) {
                                            if (!snapshotOfTeacher.hasData) {
                                              return new Text("Loading");
                                            }
                                            var teacherDocument =
                                                snapshotOfTeacher.data;
                                            return new Text(
                                              "${teacherDocument["lastname"]} ${teacherDocument["name"]}",
                                              style: TextStyle(
                                                  color: _dayTimetablePresenter
                                                      .mainPresenter
                                                      .mainPresenterModel
                                                      .themeColorEnd,
                                                  fontSize: 20),
                                            );
                                          },
                                        ),
                                        Text(
                                          snapshotOfLesson.data.documents[index]
                                              ["textbook"],
                                          style: TextStyle(
                                              color: _dayTimetablePresenter
                                                  .mainPresenter
                                                  .mainPresenterModel
                                                  .themeColorEnd,
                                              fontSize: 20),
                                        ),
                                        new RichText(
                                          text: new TextSpan(
                                            children: [
                                              new TextSpan(
                                                text: 'Ссылка на учебник',
                                                style: new TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20),
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () {
                                                        launch(snapshotOfLesson
                                                                .data
                                                                .documents[index]
                                                            ["textbook_ref"]);
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          snapshotOfLesson.data.documents[index]
                                              ["theme"],
                                          style: TextStyle(
                                              color: _dayTimetablePresenter
                                                  .mainPresenter
                                                  .mainPresenterModel
                                                  .themeColorEnd,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          snapshotOfLesson.data.documents[index]
                                              ["hometask"],
                                          style: TextStyle(
                                              color: _dayTimetablePresenter
                                                  .mainPresenter
                                                  .mainPresenterModel
                                                  .themeColorEnd,
                                              fontSize: 20),
                                        ),
                                        new RichText(
                                          text: new TextSpan(
                                            children: [
                                              new TextSpan(
                                                text: 'Ссылка на zoom',
                                                style: new TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20),
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () {
                                                        _dayTimetablePresenter
                                                            .dayTimetableModel
                                                            .incrementCountOfLessons(
                                                                snapshotOfLesson
                                                                    .data
                                                                    .documents[
                                                                        index]
                                                                    .documentID);
                                                        launch(snapshotOfLesson
                                                                .data
                                                                .documents[index]
                                                            ["zoom_link"]);
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                        flex: 9,
                      )
                    ],
                  );
                }));
        break;
      case "Student":
        return Scaffold(
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection("Lessons")
                    .where("group_id",
                        isEqualTo: _dayTimetablePresenter.mainPresenter
                            .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId)
                    .where("day_of_week",
                        isEqualTo:
                            "${_dayTimetablePresenter.dayTimetableModel.dayOfTheWeek}")
                    .snapshots(),
                builder: (context, snapshotOfLesson) {
                  if (!snapshotOfLesson.hasData)
                    return Center(
                      child: Text("Loading..."),
                    );
                  return Column(
                    children: <Widget>[
                      new Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  _dayTimetablePresenter.goBack(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: _dayTimetablePresenter.mainPresenter
                                      .mainPresenterModel.themeColorEnd,
                                ),
                                iconSize: 40.0,
                              ),
                            ),
                            Container()
                          ],
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "${_dayTimetablePresenter.dayTimetableModel.dayOfTheWeek}",
                            style: TextStyle(
                                color: _dayTimetablePresenter.mainPresenter
                                    .mainPresenterModel.themeColorEnd,
                                fontSize: 20),
                          ),
                        ),
                        flex: 1,
                      ),
                      new Expanded(
                        child: ListView.builder(
                            itemCount: snapshotOfLesson.data.documents.length,
                            itemBuilder: (_, index) {
                              return Card(
                                color: Colors.white70,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      snapshotOfLesson.data.documents[index]
                                          ["title"],
                                      style: TextStyle(
                                          color: _dayTimetablePresenter
                                              .mainPresenter
                                              .mainPresenterModel
                                              .themeColorEnd,
                                          fontSize: 20),
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance
                                          .collection("Teachers")
                                          .document(snapshotOfLesson.data
                                              .documents[index]["teacher_id"])
                                          .snapshots(),
                                      builder: (context, snapshotOfTeacher) {
                                        if (!snapshotOfTeacher.hasData) {
                                          return new Text("Loading");
                                        }
                                        var teacherDocument =
                                            snapshotOfTeacher.data;
                                        return new Text(
                                          "${teacherDocument["lastname"]} ${teacherDocument["name"]}",
                                          style: TextStyle(
                                              color: _dayTimetablePresenter
                                                  .mainPresenter
                                                  .mainPresenterModel
                                                  .themeColorEnd,
                                              fontSize: 20),
                                        );
                                      },
                                    ),
                                    Text(
                                      snapshotOfLesson.data.documents[index]
                                          ["textbook"],
                                      style: TextStyle(
                                          color: _dayTimetablePresenter
                                              .mainPresenter
                                              .mainPresenterModel
                                              .themeColorEnd,
                                          fontSize: 20),
                                    ),
                                    new RichText(
                                      text: new TextSpan(
                                        children: [
                                          new TextSpan(
                                            text: 'Ссылка на учебник',
                                            style: new TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    launch(snapshotOfLesson.data
                                                            .documents[index]
                                                        ["textbook_ref"]);
                                                  },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      snapshotOfLesson.data.documents[index]
                                          ["theme"],
                                      style: TextStyle(
                                          color: _dayTimetablePresenter
                                              .mainPresenter
                                              .mainPresenterModel
                                              .themeColorEnd,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      snapshotOfLesson.data.documents[index]
                                          ["hometask"],
                                      style: TextStyle(
                                          color: _dayTimetablePresenter
                                              .mainPresenter
                                              .mainPresenterModel
                                              .themeColorEnd,
                                          fontSize: 20),
                                    ),
                                    new RichText(
                                      text: new TextSpan(
                                        children: [
                                          new TextSpan(
                                            text: 'Ссылка на zoom',
                                            style: new TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    _dayTimetablePresenter
                                                        .dayTimetableModel
                                                        .incrementCountOfVisits(
                                                            snapshotOfLesson
                                                                .data
                                                                .documents[
                                                                    index]
                                                                .documentID,
                                                            _dayTimetablePresenter
                                                                .mainPresenter
                                                                .catalogPresenter
                                                                .userId);
                                                    launch(snapshotOfLesson.data
                                                            .documents[index]
                                                        ["zoom_link"]);
                                                  },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        flex: 9,
                      )
                    ],
                  );
                }));
        break;
    }
  }

  Future<void> _showMyDialog(int subjectLength) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Создание занятия'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название занятия',
                  ),
                ),
                TextField(
                  controller: _teacherLastName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Фамилия преподавателя',
                  ),
                ),
                TextField(
                  controller: _teacherName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Имя преподавателя',
                  ),
                ),
                TextField(
                  controller: _textBook,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название учебника',
                  ),
                ),
                TextField(
                  controller: _textBookRef,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ссылка на учебник',
                  ),
                ),
                TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Описание занятия',
                  ),
                ),
                TextField(
                  controller: _homework,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Домашнее задание',
                  ),
                ),
                TextField(
                  controller: _zoomRef,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zoom-конференция',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Подтвердить'),
              onPressed: () {
                _dayTimetablePresenter.dayTimetableModel.addNewSubjectToDB(
                    context,
                    _titleController.text,
                    _teacherLastName.text,
                    _teacherName.text,
                    _textBook.text,
                    _textBookRef.text,
                    _description.text,
                    _homework.text,
                    _zoomRef.text,
                    subjectLength + 1);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
