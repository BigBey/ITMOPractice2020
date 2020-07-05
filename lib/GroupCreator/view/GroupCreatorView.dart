import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/GroupCreator/presenter/GroupCreatorPresenter.dart';
import 'package:flutterapp/Visits/entities/Student.dart';

class GroupCreatorView extends StatefulWidget {
  var _groupCreatorPresenter;

  GroupCreatorView(GroupCreatorPresenter groupCreatorPresenter) {
    _groupCreatorPresenter = groupCreatorPresenter;
  }

  @override
  State<StatefulWidget> createState() => _GroupCreatorViewState(_groupCreatorPresenter);
}

class _GroupCreatorViewState extends State<GroupCreatorView> {
  var _groupCreatorPresenter;
  List<Student> _students;

  _GroupCreatorViewState(this._groupCreatorPresenter);

  @override
  void initState() {
    super.initState();
    _groupCreatorPresenter.initStudents();
    _students = _groupCreatorPresenter.visitsModel.students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
            child: Row(
              children: <Widget>[],
            ),
            flex: 1),
        Expanded(
            child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: CheckboxListTile(
                      title: Text("${_students[index].name}"),
                      controlAffinity:
                        ListTileControlAffinity.platform,
                      value: _students[index].visit,
                      onChanged: (bool value){
                        setState(() {
                          _students[index].visit = value;
                        });
                      },
                      activeColor: Colors.indigo,
                      checkColor: Colors.white,
                    )
                    );
                }),
            flex: 9)
      ],
    ));
  }
}
