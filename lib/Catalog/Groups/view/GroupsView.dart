
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/entities/Group.dart';
import 'package:flutterapp/Catalog/Groups/presenter/GroupsPresenter.dart';

class GroupsView extends StatefulWidget{

  var _variantsPresenter;

  GroupsView(this._variantsPresenter);

  @override
  State<StatefulWidget> createState() => _GroupsViewState(_variantsPresenter);

}

class _GroupsViewState extends State<GroupsView>{

  var _variantsPresenter;
  List<Group> _groups;

  _GroupsViewState(GroupsPresenter _variantsPresenter){
    this._variantsPresenter = _variantsPresenter;
  }

  @override
  void initState() {
    super.initState();
    _groups = _variantsPresenter.catalogPresenter.catalogModel.groups;
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
          itemCount: _groups.length,
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
                              "${_groups[index].title}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ))))));
          }),
    );
  }

  void addGroup(String groupId, String groupTitle){
    setState(() {
      _groups.add(Group(groupId, groupTitle));
    });
  }
}