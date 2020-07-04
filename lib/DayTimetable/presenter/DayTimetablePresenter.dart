
import 'package:flutterapp/DayTimetable/entities/Subject.dart';
import 'package:flutterapp/DayTimetable/view/DayTimetableView.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';

class DayTimetablePresenter{
  var _mainPresenter;
  var _groupId;
  var _dayOfTheWeek;
  List<Subject> _subjects;
  var _dayTimetableView;

  get mainPresenter => _mainPresenter;
  get dayOfTheWeek => _dayOfTheWeek;
  get groupId => _groupId;
  get subjects => _subjects;
  get dayTimetableView => _dayTimetableView;

  set groupId(value) {
    _groupId = value;
  }

  set dayOfTheWeek(value) {
    _dayOfTheWeek = value;
  }

  DayTimetablePresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _dayTimetableView = DayTimetableView(this);
  }

  void getSubjectFromDB(){
    _subjects = List<Subject>();
    _subjects.add(Subject("Алгоритмы", "Повышев", "Учебник", "Ссылка на учебник", "Описание", "Задание"));
    _subjects.add(Subject("Алгоритмы", "Повышев", "Учебник", "Ссылка на учебник", "Описание", "Задание"));
    _subjects.add(Subject("Алгоритмы", "Повышев", "Учебник", "Ссылка на учебник", "Описание", "Задание"));
  }

  void addNewSubjectToDB(){
    //TODO
  }
}