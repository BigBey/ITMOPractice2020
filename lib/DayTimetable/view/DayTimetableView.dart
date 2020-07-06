import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/DayTimetable/entities/Subject.dart';
import 'package:flutterapp/DayTimetable/presenter/DayTimetablePresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';

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
  TextEditingController _teacherName;
  TextEditingController _textBook;
  TextEditingController _textBookRef;
  TextEditingController _description;
  TextEditingController _homework;

  DayTimetableViewState(DayTimetablePresenter dayTimetablePresenter) {
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _teacherName = TextEditingController();
    _textBook = TextEditingController();
    _textBookRef = TextEditingController();
    _description = TextEditingController();
    _homework = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _teacherName.dispose();
    _textBook.dispose();
    _textBookRef.dispose();
    _description.dispose();
    _homework.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance
                .collection("Lessons")
                .where("group_id",
                    isEqualTo: _dayTimetablePresenter.mainPresenter
                        .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Text("Loading..."),
                );
              return Column(
                children: <Widget>[
                  new Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                EgeHelper.plus,
                                color: _dayTimetablePresenter.mainPresenter
                                    .mainPresenterModel.themeColorEnd,
                              ),
                              onPressed: () {
                                _showMyDialog();
                              },
                            ))
                      ],
                    ),
                    flex: 1,
                  ),
                  new Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                              onTap: () {
                                _dayTimetablePresenter.goToVisits(context);
                              },
                              child: Card(
                                child: Column(
                                  children: <Widget>[
                                    Text(snapshot.data.documents[index]
                                        ["title"]),
                                    StreamBuilder(
                                      stream: Firestore.instance
                                          .collection("Teachers")
                                          .document(snapshot.data
                                              .documents[index]["teacher_id"])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return new Text("Loading");
                                        }
                                        var teacherDocument = snapshot.data;
                                        return new Text(
                                            "${teacherDocument["lastname"]} ${teacherDocument["name"]}");
                                      },
                                    ),
                                    Text(snapshot.data.documents[index]
                                        ["textbook"]),
                                    Text(snapshot.data.documents[index]
                                        ["textbook_ref"]),
                                    Text(snapshot.data.documents[index]
                                        ["theme"]),
                                    Text(snapshot.data.documents[index]
                                        ["hometask"]),
                                    Text(snapshot.data.documents[index]
                                        ["zoom_link"]),
                                  ],
                                ),
                              ));
                        }),
                    flex: 9,
                  )
                ],
              );
            }));
  }

  Future<void> _showMyDialog() async {
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
                  controller: _teacherName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ФИО преподавателя',
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
