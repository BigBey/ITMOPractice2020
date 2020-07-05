
import 'package:flutterapp/DayTimetable/entities/Subject.dart';

class DayTimetableModel{
  var _dayTimetablePresenter;
  List<Subject> _subjects;

  List<Subject> get subjects => _subjects;

  DayTimetableModel(this._dayTimetablePresenter);

  void getSubjectsFromDB(){
    _subjects = List<Subject>();
    _subjects.add(Subject("Алгоритмы", "Повышев", "Учебник", "Ссылка на учебник", "Описание", "Задание"));
    _subjects.add(Subject("Алгоритмы", "Повышев", "Учебник", "Ссылка на учебник", "Описание", "Задание"));
    _subjects.add(Subject("Алгоритмы", "Повышев", "Учебник", "Ссылка на учебник", "Описание", "Задание"));
  }

  void addNewSubjectToDB(){
    //TODO
  }
}