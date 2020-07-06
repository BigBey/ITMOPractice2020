
import 'package:flutterapp/Catalog/Groups/view/GroupsView.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';


class GroupsPresenter{

  var _groupsView;
  var _catalogPresenter;

  get groupsView => _groupsView;
  get catalogPresenter => _catalogPresenter;

  GroupsPresenter(CatalogPresenter catalogPresenter){
    _groupsView = new GroupsView(this);
    _catalogPresenter = catalogPresenter;
  }
}