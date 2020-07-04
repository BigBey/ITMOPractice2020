import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Visits/entities/Student.dart';
import 'package:flutterapp/Visits/presenter/VisitsPresenter.dart';

class VisitsView extends StatefulWidget {
  var _visitsPresenter;

  VisitsView(VisitsPresenter visitsPresenter) {
    _visitsPresenter = visitsPresenter;
  }

  @override
  State<StatefulWidget> createState() => _VisitsViewState(_visitsPresenter);
}

class _VisitsViewState extends State<VisitsView> {
  var _visitsPresenter;
  List<Student> _students;

  _VisitsViewState(this._visitsPresenter);

  @override
  void initState() {
    super.initState();
    _visitsPresenter.initStudents();
    _students = new List();
    _students = _visitsPresenter.students;
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
