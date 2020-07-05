
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';

class VisitsModel{
  var _visitsPresenter;
  List<Student> _students;

  List<Student> get students => _students;

  VisitsModel(VisitsPresenter visitsPresenter){
    _visitsPresenter = visitsPresenter;
  }

  void initStudents(){
    _students = new List();
    _students.add(Student("123", "Иванов Иван Иванович", false));
    _students.add(Student("123", "Иванов Иван Иванович", false));
    _students.add(Student("123", "Иванов Иван Иванович", false));
  }

  void checkVisits(){
    //TODO
  }
}