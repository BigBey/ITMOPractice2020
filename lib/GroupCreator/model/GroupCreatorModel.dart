
import 'package:flutterapp/GroupCreator/entities/Student.dart';
import 'package:flutterapp/GroupCreator/presenter/GroupCreatorPresenter.dart';

class GroupCreatorModel{
  var _groupCreatorPresenter;
  List<Student> _students;

  List<Student> get students => _students;

  GroupCreatorModel(GroupCreatorPresenter groupCreatorPresenter){
    _groupCreatorPresenter = groupCreatorPresenter;
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