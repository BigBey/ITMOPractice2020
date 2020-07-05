

import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/entities/Group.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';

class CatalogModel{
  var _catalogPresenter;
  var _amountOfAnswers = "50 из 600";
  List<Group> _groups;

  get amountOfAnswers => _amountOfAnswers;
  List<Group> get groups => _groups;

  set amountOfAnswers(value) {
    _amountOfAnswers = value;
  }

  CatalogModel(CatalogPresenter catalogPresenter){
    _catalogPresenter = catalogPresenter;
    _groups = new List<Group>();
    _groups.add(Group("123", "M32031"));
    _groups.add(Group("123", "M32031"));
    _groups.add(Group("123", "M32031"));
  }

  void initGroups(){
    //TODO implement using Model and firebase
  }

  void addGroup(String groupTitle){
    //TODO add group to DB using model
    _groups.add(Group("1213", groupTitle));
  }
}