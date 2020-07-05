
import 'package:flutterapp/Catalog/Groups/view/GroupsView.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';


class GroupsPresenter{

  var _variantsView;
  var _catalogPresenter;

  get variantsView => _variantsView;

  get catalogPresenter => _catalogPresenter;

  GroupsPresenter(CatalogPresenter catalogPresenter){
    _variantsView = new GroupsView(this);
    _catalogPresenter = catalogPresenter;
  }
}