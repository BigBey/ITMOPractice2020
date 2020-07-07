import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/presenter/GroupsPresenter.dart';
import 'package:flutterapp/Catalog/NewGroupCreator/presenter/NewGroupCreatorPresenter.dart';
import 'package:flutterapp/Catalog/model/CatalogModel.dart';
import 'package:flutterapp/Catalog/view/CatalogView.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';

class CatalogPresenter {
  var _groupsPresenter;
  var _newGroupCreatorPresenter;
  var _mainPresenter;

  get mainPresenter => _mainPresenter;
  var _catalogView;
  var _catalogModel;
  var _state;

  get catalogModel => _catalogModel;

  get groupsPresenter => _groupsPresenter;

  get tasksPresenter => _newGroupCreatorPresenter;


  set state(value) {
    _state = value;
  }

  CatalogPresenter(MainPresenter mainPresenter) {
    _mainPresenter = mainPresenter;
    _catalogView = CatalogView(this);
    _catalogModel = CatalogModel(this);
    _groupsPresenter = GroupsPresenter(this);
    _newGroupCreatorPresenter = NewGroupCreatorPresenter(this);
  }

  get catalogView => _catalogView;

//TODO: You can create method which has returned Widget and it is based on _state

  void loadCatalogModel() {
    switch (_state) {
      case "Student":
        {
          _mainPresenter.mainPresenterModel.themeColorEnd = Colors.indigo;
          _mainPresenter.mainPresenterModel.themeColorStart = Colors.indigo;
          _mainPresenter.mainPresenterModel.amountOfTasks = 26;
        }
        break;

      case "Teacher":
        {
          _mainPresenter.mainPresenterModel.themeColorEnd = Colors.indigo;
          _mainPresenter.mainPresenterModel.themeColorStart = Colors.indigo;
          _mainPresenter.mainPresenterModel.amountOfTasks = 12;
        }
        break;

      default:
        {
          _catalogModel._color = Colors.redAccent;
        }
    }
  }

  void goToTest(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.testPresenter.testView),
    );
  }

  void goToDayTimetable(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => _mainPresenter.daysOfTheWeekPresenter.daysOfTheWeekView),
    );
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void setGroupId(String _groupId){
    mainPresenter.daysOfTheWeekPresenter.daysOfTheWeekModel.groupId = _groupId;
  }

  void addGroup(String groupTitle){
    //TODO add group to DB using model
    _catalogModel.addGroup(groupTitle);
  }
}
