
import 'package:flutterapp/DayTimetable/entities/Subject.dart';

class DayTimetableModel{
  var _dayTimetablePresenter;
  String dayOfTheWeek;

  get dayTimetablePresenter => _dayTimetablePresenter;
  set dayTimetablePresenter(value) {
    _dayTimetablePresenter = value;
  }

  DayTimetableModel(this._dayTimetablePresenter);

  void addNewSubjectToDB(){
    //TODO
  }
}