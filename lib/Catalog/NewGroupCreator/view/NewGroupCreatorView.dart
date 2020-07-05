import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/NewGroupCreator/presenter/NewGroupCreatorPresenter.dart';

class NewGroupCreatorView extends StatefulWidget{
  var _tasksPresenter;

  NewGroupCreatorView(this._tasksPresenter);

  @override
  State<StatefulWidget> createState() => _NewGroupCreatorViewState(_tasksPresenter);
}

class _NewGroupCreatorViewState extends State<NewGroupCreatorView>{
  var _tasksPresenter;
  TextEditingController _groupTitle;

  _NewGroupCreatorViewState(NewGroupCreatorPresenter _tasksPresenter){
    this._tasksPresenter = _tasksPresenter;
  }

  @override
  void initState() {
    super.initState();
    _groupTitle = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            controller: _groupTitle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Название группы',
            ),
          ),
          FlatButton(
            onPressed: (){
              Firestore.instance.collection("Groups").add(
                {"group_name" : "${_groupTitle.text}"}
              );
            },
            child: Text("Подтвердить"),
          )

        ],
      ),
    );
  }
}