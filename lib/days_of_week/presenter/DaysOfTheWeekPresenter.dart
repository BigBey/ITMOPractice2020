
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/days_of_week/view/DaysOfTheWeekView.dart';

class DaysOfTheWeekPresenter{
  var _daysOfTheWeekView;
  var _mainPresenter;
  var _groupId;

  get daysOfTheWeekView => _daysOfTheWeekView;
  get groupId => _groupId;
  set groupId(value) {
    _groupId = value;
  }

  DaysOfTheWeekPresenter(MainPresenter mainPresenter){
    _daysOfTheWeekView = new DaysOfTheWeekView(this);
    _mainPresenter = mainPresenter;
  }

  void goToDayTimetable(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.dayTimetablePresenter.dayTimetableView),
    );
  }

}