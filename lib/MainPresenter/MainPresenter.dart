import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/Blitz/presenter/BlitzPresenter.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';
import 'package:flutterapp/DayTimetable/presenter/DayTimetablePresenter.dart';
import 'package:flutterapp/GroupCreator/presenter/GroupCreatorPresenter.dart';
import 'package:flutterapp/MainPresenter/view/MainPresenterView.dart';
import 'package:flutterapp/MainScreen/presenter/MainScreenPresenter.dart';
import 'package:flutterapp/Signature/presenter/SignaturePresenter.dart';
import 'package:flutterapp/Statistics/presenter/StatisticsPresenter.dart';
import 'package:flutterapp/StatisticsStudent/presenter/StatisticsStudentPresenter.dart';
import 'package:flutterapp/Test/presenter/TestPresenter.dart';
import 'package:flutterapp/Theory/presenter/TheoryPresenter.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';
import 'package:flutterapp/days_of_week/presenter/DaysOfTheWeekPresenter.dart';

import 'model/MainPresenterModel.dart';

class MainPresenter{

  var _mainScreenPresenter;
  var _catalogPresenter;
  var _theoryPresenter;
  var _blitzPresenter;
  var _statisticsPresenter;
  var _testPresenter;
  var _signaturePresenter;
  var _daysOfTheWeekPresenter;
  var _dayTimetablePresenter;
  var _visitsPresenter;
  var _groupCreatorPresenter;
  var _statisticsStudentPresenter;

  var _mainPresenterView;
  var _mainPresenterModel;

  get mainPresenterModel => _mainPresenterModel;
  get mainPresenterView => _mainPresenterView;
  get mainScreenPresenter => _mainScreenPresenter;
  get catalogPresenter => _catalogPresenter;
  get theoryPresenter => _theoryPresenter;
  get blitzPresenter => _blitzPresenter;
  get statisticsPresenter => _statisticsPresenter;
  get testPresenter => _testPresenter;
  get signaturePresenter => _signaturePresenter;
  get daysOfTheWeekPresenter => _daysOfTheWeekPresenter;
  get dayTimetablePresenter => _dayTimetablePresenter;
  get visitsPresenter => _visitsPresenter;
  get groupCreatorPresenter => _groupCreatorPresenter;
  get statisticsStudentPresenter => _statisticsStudentPresenter;

  MainPresenter(){
    _mainPresenterModel = MainPresenterModel(this);
    _mainPresenterView = MainPresenterView(this);
    _mainScreenPresenter = MainScreenPresenter(this);
    _catalogPresenter = CatalogPresenter(this);
    _theoryPresenter = TheoryPresenter(this);
    _testPresenter = TestPresenter(this);
    _blitzPresenter = BlitzPresenter();
    _signaturePresenter = SignaturePresenter(this);
    _statisticsPresenter = StatisticsPresenter(this);
    _daysOfTheWeekPresenter = DaysOfTheWeekPresenter(this);
    _dayTimetablePresenter = DayTimetablePresenter(this);
    _visitsPresenter = VisitsPresenter(this);
    _groupCreatorPresenter = GroupCreatorPresenter(this);
    _statisticsStudentPresenter = StatisticsStudentPresenter(this);
  }


}


void main(){
  var mainPresenter = MainPresenter();
}