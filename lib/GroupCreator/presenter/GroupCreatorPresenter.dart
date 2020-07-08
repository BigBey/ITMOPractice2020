
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/GroupCreator/view/GroupCreatorView.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/GroupCreator/model/GroupCreatorModel.dart';

class GroupCreatorPresenter{
  var _mainPresenter;
  var _groupCreatorView;
  var _groupCreatorModel;

  get mainPresenter => _mainPresenter;
  get groupCreatorView => _groupCreatorView;
  get groupCreatorModel => _groupCreatorModel;

  GroupCreatorPresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _groupCreatorView = new GroupCreatorView(this);
    _groupCreatorModel = new GroupCreatorModel(this);
  }

  void initStudents(){
    _groupCreatorModel.initStudents();
  }

  void checkVisits(){
    //TODO
    _groupCreatorModel.checkVisits();
  }

  void goBack(BuildContext context){
    Navigator.pop(context);
  }
}