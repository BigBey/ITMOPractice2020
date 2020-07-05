
import 'package:flutterapp/GroupCreator/view/GroupCreatorView.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/GroupCreator/model/GroupCreatorModel.dart';

class GroupCreatorPresenter{
  var _mainPresenter;
  var _visitsView;
  var _visitsModel;

  get mainPresenter => _mainPresenter;
  get visitsView => _visitsView;
  get visitsModel => _visitsModel;


  GroupCreatorPresenter(MainPresenter mainPresenter){
    _mainPresenter = mainPresenter;
    _visitsView = new GroupCreatorView(this);
    _visitsModel = new GroupCreatorModel(this);
  }

  void initStudents(){
    _visitsModel.initStudents();
  }

  void checkVisits(){
    //TODO
    _visitsModel.checkVisits();
  }
}