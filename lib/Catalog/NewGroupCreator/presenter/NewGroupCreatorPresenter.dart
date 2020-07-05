import 'package:flutterapp/Catalog/NewGroupCreator/view/NewGroupCreatorView.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';

class NewGroupCreatorPresenter{

  var _tasksView;
  var _catalogPresenter;

  get tasksView => _tasksView;
  get catalogPresenter => _catalogPresenter;

  NewGroupCreatorPresenter(CatalogPresenter catalogPresenter){
    _tasksView = new NewGroupCreatorView(this);
    _catalogPresenter = catalogPresenter;
  }

}