import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class StatisticsModel {
  var _statisticsPresenter;

  StatisticsModel(this._statisticsPresenter);

  /*Future<double> getAverageAttandance(String groupId) {
    var countOfStudents = 0;
    var sumOfAverageStudentAttendance = 0.0;
    return Firestore.instance
        .collection("Students")
        .where("group_id", isEqualTo: groupId)
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        var countOfVisits = 0;
        var sumOfAverageVisitAttendance = 0.0;
        Firestore.instance.collection("Visits").where(
            "student_id", isEqualTo: element.documentID).getDocuments().then((
            value) {
              value.documents.forEach((element) {
                Firestore.instance.collection("Lessons").document(element.data["lesson_id"]).get().then((value) {
                  if(value.data["count"] != 0) {
                    sumOfAverageVisitAttendance +=
                        element.data["visits_count"] / value.data["count"];
                  }else{
                    sumOfAverageVisitAttendance += 0;
                  }
                  countOfVisits++;
                });
              });
        });
        if(countOfVisits != 0) {
          sumOfAverageStudentAttendance +=
              sumOfAverageVisitAttendance / countOfVisits;
        }else{
          sumOfAverageStudentAttendance += 0;
        }
        countOfStudents++;
      });
      return sumOfAverageStudentAttendance/countOfStudents;
    });
  }*/

  Future<double> getAverageAttandance(String groupId){
    try {
      return Firestore.instance
          .collection('Students')
          .where("group_id", isEqualTo: groupId)
          .getDocuments().then((valueOfStudents) async {
              var sumAttendance = 0.0;
              var count = 0;
              for(int i = 0; i < valueOfStudents.documents.length; i++){
                sumAttendance += valueOfStudents.documents[i]["visits"];
                count++;
              }
              if(count != 0) {
                return sumAttendance / count;
              }
              return 0.0;
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
