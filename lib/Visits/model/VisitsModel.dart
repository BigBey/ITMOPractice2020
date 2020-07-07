import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';

class VisitsModel {
  var _visitsPresenter;
  String _lessonId;


  String get lessonId => _lessonId;


  set lessonId(String value) {
    _lessonId = value;
  }

  VisitsModel(VisitsPresenter visitsPresenter) {
    _visitsPresenter = visitsPresenter;
  }

  Future<void> markStudentVisit(String studentId, String lessonId, bool visit){
    try {
      return Firestore.instance
          .collection('Visits')
          .where("student_id", isEqualTo: studentId)
          .where("lesson_id", isEqualTo: lessonId)
          .getDocuments().then((value) {
        value.documents[0].reference.updateData({
          "last_visit": visit,
          "visits_count": FieldValue.increment(visit? 1 : -1)
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> getStudentVisit(String studentId, String lessonId){
    try {
      return Firestore.instance
          .collection('Visits')
          .where("student_id", isEqualTo: studentId)
          .where("lesson_id", isEqualTo: lessonId)
          .getDocuments().then((value) {
        return value.documents[0]["last_visit"];
      });
    } catch (e) {
      print(e.toString());
    }
  }
}