
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/StatisticsStudent/model/StatisticsStudentModel.dart';
import 'package:flutterapp/StatisticsStudent/view/StatisticsStudentView.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/model/VisitsModel.dart';
import 'package:flutterapp/Visits/view/VisitsView.dart';

class StatisticsStudentPresenter{
  var _mainPresenter;
  var _statisticsStudentView;
  var _statisticsStudentModel;

  get mainPresenter => _mainPresenter;
  get statisticsStudentView => _statisticsStudentView;
  get statisticsStudentModel => _statisticsStudentModel;


  StatisticsStudentPresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _statisticsStudentView = new StatisticsStudentView(this);
    _statisticsStudentModel = StatisticsStudentModel(this);
  }

  void goBack(BuildContext context){
    Navigator.pop(context);
  }
}