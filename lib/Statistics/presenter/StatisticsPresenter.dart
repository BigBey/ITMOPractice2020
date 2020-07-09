
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/view/GroupsView.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/Statistics/model/StatisticsModel.dart';
import 'package:flutterapp/Statistics/view/StatisticsView.dart';


class StatisticsPresenter{
  var _statisticsView;
  var _statisticsModel;
  var _mainPresenter;

  get statisticsView => _statisticsView;
  get mainPresenter => _mainPresenter;

  get statisticsModel => _statisticsModel;

  StatisticsPresenter(MainPresenter mainPresenter){
    _statisticsView = new StatisticsView(this);
    _statisticsModel = new StatisticsModel(this);
    _mainPresenter = mainPresenter;
  }

  void goToStatisticsStudent(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.statisticsStudentPresenter.statisticsStudentView),
    );
  }
}