
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/view/VisitsView.dart';

class VisitsPresenter{
  var _mainPresenter;
  var _visitsView;
  List<Student> _students;

  get mainPresenter => _mainPresenter;
  get visitsView => _visitsView;
  List<Student> get students => _students;

  VisitsPresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _visitsView = new VisitsView(this);
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