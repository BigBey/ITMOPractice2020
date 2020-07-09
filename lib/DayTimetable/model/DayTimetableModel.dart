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

  Future<void> addNewSubjectToDB(
      BuildContext context,
      String title,
      String teacherLastName,
      String teacherName,
      String textbook,
      String textbookRef,
      String theme,
      String hometask,
      String zoomRef,
      int index,
      String startTime,
      String endTime) async {
    var teacherId = "";
    DocumentReference ref = await Firestore.instance.collection("Lessons").add({
      "day_of_week": _dayOfTheWeek,
      "group_id": _dayTimetablePresenter
          .mainPresenter.daysOfTheWeekPresenter.daysOfTheWeekModel.groupId,
      "title": (title != "")? "Предмет": title,
      "teacher_id": teacherId,
      "textbook": (textbook != "")? "Учебник": textbook,
      "textbook_ref": (textbookRef != "")? "Ссылка на учебник": textbookRef,
      "theme": (theme != "")? "Тема занятия": theme,
      "hometask": (hometask != "")? "Домашнее задание": hometask,
      "zoom_link": (zoomRef != "")? "Ссылка на zoom": zoomRef,
      "index": index,
      "start_time": startTime,
      "end_time": endTime
    });
    Firestore.instance
        .collection("Students")
        .where("group_id",
            isEqualTo: _dayTimetablePresenter.mainPresenter
                .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId)
        .getDocuments()
        .then((valueOfStudents) {
      valueOfStudents.documents.forEach((element) {
        Firestore.instance.collection("Visits").add({
          "lesson_id": ref.documentID,
          "student_id": element.documentID,
          "visits_count": 0,
          "last_visit": false
        });
      });
    });

    Firestore.instance
        .collection("Teachers")
        .where("lastname", isEqualTo: teacherLastName)
        .where("name", isEqualTo: teacherName)
        .getDocuments()
        .then((value) {
      teacherId = value.documents[0].documentID;
      try {
        Firestore.instance
            .collection('Lessons')
            .document(ref.documentID)
            .updateData({'teacher_id': teacherId});
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Future<void> incrementCountOfLessons(String lessonId) {
    try {
      return Firestore.instance
          .collection('Lessons')
          .document(lessonId).updateData({
        "count": FieldValue.increment(1)
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> incrementCountOfVisits(String lessonId, String studentId) {
    try {
      return Firestore.instance
          .collection('Visits')
          .where("lesson_id", isEqualTo: lessonId).where("student_id", isEqualTo: studentId).getDocuments().then((value) {
         value.documents[0].reference.updateData({
           "visits_count": FieldValue.increment(1),
           "last_visit": true
         });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> incrementGroupCountOfVisits(String groupId) {
    try {
      return Firestore.instance
          .collection('Groups')
          .document(groupId).updateData({
        "visits": FieldValue.increment(1)
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> incrementStudentCountOfVisits(String studentId) {
    try {
      return Firestore.instance
          .collection('Students')
          .document(studentId).updateData({
        "visits": FieldValue.increment(1)
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
