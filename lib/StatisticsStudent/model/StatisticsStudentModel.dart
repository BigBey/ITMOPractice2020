import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/StatisticsStudent/presenter/StatisticsStudentPresenter.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';

class StatisticsStudentModel {
  var _statisticsStudentPresenter;
  String _groupId;
  String _groupTitle;

  String get groupId => _groupId;

  set groupId(String value) {
    _groupId = value;
  }


  String get groupTitle => _groupTitle;

  set groupTitle(String value) {
    _groupTitle = value;
  }

  StatisticsStudentModel(StatisticsStudentPresenter statisticsStudentPresenter) {
    _statisticsStudentPresenter = statisticsStudentPresenter;
  }

  Future<int> getStudentVisits(String studentId){
    try {
      return Firestore.instance
          .collection('Students')
          .document(studentId)
          .get().then((value) {
        return value.data["visits"];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> getGroupVisits(String groupId){
    try {
      return Firestore.instance
          .collection('Groups')
          .document(groupId)
          .get().then((value) {
        return value.data["visits"];
      });
    } catch (e) {
      print(e.toString());
    }
  }
}