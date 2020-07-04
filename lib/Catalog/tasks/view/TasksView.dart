import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/tasks/presenter/TasksPresenter.dart';
import 'package:flutterapp/Catalog/variants/view/Item.dart';
class TasksView extends StatefulWidget{
  var _tasksPresenter;

  TasksView(this._tasksPresenter);

  @override
  State<StatefulWidget> createState() => _TasksViewState(_tasksPresenter);
}

class _TasksViewState extends State<TasksView>{
  var _tasksPresenter;
  TextEditingController _groupTitle;

  _TasksViewState(TasksPresenter _tasksPresenter){
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

            },
            child: Text("Подтвердить"),
          )

        ],
      ),
    );
  }
}