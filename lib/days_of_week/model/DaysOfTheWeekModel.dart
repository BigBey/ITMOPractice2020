
import 'package:flutterapp/days_of_week/presenter/DaysOfTheWeekPresenter.dart';

class DaysOfTheWeekModel{
  var _daysOfTheWeekPresenter;
  String _groupId;

  get daysOfTheWeekPresenter => _daysOfTheWeekPresenter;
  String get groupId => _groupId;
  set groupId(String value) {
    _groupId = value;
  }

  DaysOfTheWeekModel(DaysOfTheWeekPresenter daysOfTheWeekPresenter){
    _daysOfTheWeekPresenter = daysOfTheWeekPresenter;
  }
}