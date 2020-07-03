
import 'package:flutterapp/MainPresenter/MainPresenter.dart';

class DayTimetablePresenter{
  var _mainPresenter;

  get mainPresenter => _mainPresenter;

  DayTimetablePresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
  }
}