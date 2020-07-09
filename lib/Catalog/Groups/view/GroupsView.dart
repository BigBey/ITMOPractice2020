
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/entities/Group.dart';
import 'package:flutterapp/Catalog/Groups/presenter/GroupsPresenter.dart';

class GroupsView extends StatefulWidget{

  var _groupsPresenter;

  GroupsView(this._groupsPresenter);

  @override
  State<StatefulWidget> createState() => _GroupsViewState(_groupsPresenter);

}

class _GroupsViewState extends State<GroupsView>{

  var _groupsPresenter;
  List<Group> _groups;

  _GroupsViewState(GroupsPresenter _groupsPresenter){
    this._groupsPresenter = _groupsPresenter;
  }

  @override
  void initState() {
    super.initState();
    _groups = _groupsPresenter.catalogPresenter.catalogModel.groups;
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
      child: StreamBuilder(
        stream: Firestore.instance.collection("Groups").orderBy("group_name").snapshots(),
        builder: (context, snapshot){
          if (!snapshot.hasData) return const Text('Loading...');
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (_, index){
                return Center(
                    child: GestureDetector(
                        onTap: () {
                          _groupsPresenter.catalogPresenter.setGroupId(snapshot.data.documents[index].documentID);
                          _groupsPresenter.catalogPresenter.goToDayTimetable(context);
                        },
                        child: Container(
                            height: 100,
                            width: 100,
                            child: Card(
                                color:  _groupsPresenter.catalogPresenter.mainPresenter.mainPresenterModel.themeColorEnd,
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(child: Text(
                                  "${snapshot.data.documents[index]["group_name"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))))));
              });
        },
      )
    );
  }

  void addGroup(String groupId, String groupTitle){
    setState(() {
      _groups.add(Group(groupId, groupTitle));
    });
  }
}