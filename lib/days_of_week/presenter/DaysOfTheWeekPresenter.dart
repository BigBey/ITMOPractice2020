
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/days_of_week/model/DaysOfTheWeekModel.dart';
import 'package:flutterapp/days_of_week/view/DaysOfTheWeekView.dart';

class DaysOfTheWeekPresenter{
  var _daysOfTheWeekView;
  var _daysOfTheWeekModel;
  var _mainPresenter;

  get daysOfTheWeekView => _daysOfTheWeekView;
  get daysOfTheWeekModel => _daysOfTheWeekModel;

  DaysOfTheWeekPresenter(MainPresenter mainPresenter){
    _daysOfTheWeekView = new DaysOfTheWeekView(this);
    _daysOfTheWeekModel = new DaysOfTheWeekModel(this);
    _mainPresenter = mainPresenter;
  }

  void goToDayTimetable(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.dayTimetablePresenter.dayTimetableView),
    );
  }

  void goToGroupCreator(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.groupCreatorPresenter.groupCreatorView),
    );
  }

}