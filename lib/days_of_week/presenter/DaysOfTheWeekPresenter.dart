
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/days_of_week/view/DaysOfTheWeekView.dart';

class DaysOfTheWeekPresenter{
  var _daysOfTheWeekView;
  var _mainPresenter;

  get daysOfTheWeekView => _daysOfTheWeekView;

  DaysOfTheWeekPresenter(MainPresenter mainPresenter){
    _daysOfTheWeekView = new DaysOfTheWeekView(this);
    _mainPresenter = mainPresenter;
  }



}