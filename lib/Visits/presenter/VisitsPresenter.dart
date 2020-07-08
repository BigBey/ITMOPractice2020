
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/model/VisitsModel.dart';
import 'package:flutterapp/Visits/view/VisitsView.dart';

class VisitsPresenter{
  var _mainPresenter;
  var _visitsView;
  var _visitsModel;

  get mainPresenter => _mainPresenter;
  get visitsView => _visitsView;
  get visitsModel => _visitsModel;


  VisitsPresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _visitsView = new VisitsView(this);
    _visitsModel = VisitsModel(this);
  }

  void initStudents(){
    _visitsModel.initStudents();
  }

  void checkVisits(){
    //TODO
    _visitsModel.checkVisits();
  }

  void goBack(BuildContext context){
    Navigator.pop(context);
  }
}