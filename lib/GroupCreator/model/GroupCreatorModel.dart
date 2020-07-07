import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/GroupCreator/entities/Student.dart';
import 'package:flutterapp/GroupCreator/presenter/GroupCreatorPresenter.dart';

class GroupCreatorModel {
  var _groupCreatorPresenter;
  List<Student> _students;

  List<Student> get students => _students;

  GroupCreatorModel(GroupCreatorPresenter groupCreatorPresenter) {
    _groupCreatorPresenter = groupCreatorPresenter;
  }

  void initStudents() {
    _students = new List();
    _students.add(Student("123", "Иванов Иван Иванович", false));
    _students.add(Student("123", "Иванов Иван Иванович", false));
    _students.add(Student("123", "Иванов Иван Иванович", false));
  }

  void addNewStudentToTheGroup(String lastname, String name, String email) {
    Firestore.instance.collection("Students").add(
        {
          "email": email,
          "group_id": _groupCreatorPresenter.mainPresenter
              .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId,
          "lastname": lastname,
          "name": name
        }
    ).then((valueOfStudent) {
      Firestore.instance.collection("Lessons").where("group_id",
          isEqualTo: _groupCreatorPresenter.mainPresenter.daysOfTheWeekPresenter
              .daysOfTheWeekModel.groupId).getDocuments().then((valueOfLesson) => {
                valueOfLesson.documents.forEach((element) {
                  Firestore.instance.collection("Visits").add({
                  "lesson_id": element.documentID,
                    "student_id": valueOfStudent.documentID,
                    "visits_count": 0,
                    "last_visit": false
                  });
                })

      });
    });
  }
}