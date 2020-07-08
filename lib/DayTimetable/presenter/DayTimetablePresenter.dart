
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/DayTimetable/entities/Subject.dart';
import 'package:flutterapp/DayTimetable/model/DayTimetableModel.dart';
import 'package:flutterapp/DayTimetable/view/DayTimetableView.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';

class DayTimetablePresenter{
  var _mainPresenter;
  var _groupId;
  var _dayOfTheWeek;
  List<Subject> _subjects;
  var _dayTimetableView;
  var _dayTimetableModel;

  get mainPresenter => _mainPresenter;
  get dayOfTheWeek => _dayOfTheWeek;
  get groupId => _groupId;
  get subjects => _subjects;
  get dayTimetableView => _dayTimetableView;
  get dayTimetableModel => _dayTimetableModel;

  set groupId(value) {
    _groupId = value;
  }

  set dayOfTheWeek(value) {
    _dayOfTheWeek = value;
  }

  DayTimetablePresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _dayTimetableView = DayTimetableView(this);
    _dayTimetableModel = DayTimetableModel(this);
  }

  void addNewSubjectToDB(){
    //TODO
    _dayTimetableModel.addNewSubjectToDB();
  }

  void goToVisits(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.visitsPresenter.visitsView),
    );
  }

  void goBack(BuildContext context){
    Navigator.pop(context);
  }
}