import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/DayTimetable/entities/Subject.dart';
import 'package:path/path.dart';

class DayTimetableModel {
  var _dayTimetablePresenter;
  String _dayOfTheWeek;

  String get dayOfTheWeek => _dayOfTheWeek;

  set dayOfTheWeek(String value) {
    _dayOfTheWeek = value;
  }

  DayTimetableModel(this._dayTimetablePresenter);

  void addNewSubjectToDB(
      BuildContext context,
      String title,
      String teacherLastName,
      String teacherName,
      String textbook,
      String textbookRef,
      String theme,
      String hometask,
      String zoomRef,
      int index) {
    var teacherId = "";
    /*Firestore.instance.collection("Teachers").where("lastname", isEqualTo: teacherLastName).where("name", isEqualTo: teacherName).getDocuments().then((querySnapshot) {
      teacherId = querySnapshot.documents[0].documentID;
    });*/
    Firestore.instance.collection("Lessons").add({
      "day_of_week": _dayOfTheWeek,
      "group_id": _dayTimetablePresenter.mainPresenter.daysOfTheWeekPresenter.daysOfTheWeekModel.groupId,
      "title": title,
      "teacher_id": teacherId,
      "textbook": textbook,
      "textbook_ref": textbookRef,
      "theme": theme,
      "hometask": hometask,
      "zoom_link": zoomRef,
      "index": index
    });
  }
}
