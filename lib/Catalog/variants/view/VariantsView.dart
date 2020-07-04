
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/variants/entities/Group.dart';
import 'package:flutterapp/Catalog/variants/presenter/VariantsPresenter.dart';
import 'package:flutterapp/Catalog/variants/view/Item.dart';

class VariantsView extends StatelessWidget{

  var _variantsPresenter;
  List<Group> groups;

  VariantsView(VariantsPresenter _variantsPresenter){
    this._variantsPresenter = _variantsPresenter;
    groups = List<Group>();
    groups.add(Group("123", "M32031"));
    groups.add(Group("123", "M32031"));
    groups.add(Group("123", "M32031"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGridView(context),
    );
  }

  Widget buildGridView(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: groups.length,
          itemBuilder: (_, index){
            return Center(
                child: GestureDetector(
                    onTap: () {
                      _variantsPresenter.catalogPresenter.goToDayTimetable(context);
                    },
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Card(
                            color:  _variantsPresenter.catalogPresenter.mainPresenter.mainPresenterModel.themeColorEnd,
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(child: Text(
                              "${groups[index].title}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ))))));
          }),
    );
  }
}