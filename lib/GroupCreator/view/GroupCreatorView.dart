import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/GroupCreator/entities/Student.dart';
import 'package:flutterapp/GroupCreator/presenter/GroupCreatorPresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';

class GroupCreatorView extends StatefulWidget {
  var _groupCreatorPresenter;

  GroupCreatorView(GroupCreatorPresenter groupCreatorPresenter) {
    _groupCreatorPresenter = groupCreatorPresenter;
  }

  @override
  State<StatefulWidget> createState() =>
      _GroupCreatorViewState(_groupCreatorPresenter);
}

class _GroupCreatorViewState extends State<GroupCreatorView> {
  var _groupCreatorPresenter;
  List<Student> _students;
  TextEditingController _lastNameController;
  TextEditingController _nameController;
  TextEditingController _emailController;

  _GroupCreatorViewState(this._groupCreatorPresenter);

  @override
  void initState() {
    super.initState();
    _groupCreatorPresenter.initStudents();
    _students = _groupCreatorPresenter.groupCreatorModel.students;
    _lastNameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance
                .collection("Students")
                .where("group_id",
                    isEqualTo: _groupCreatorPresenter.mainPresenter
                        .daysOfTheWeekPresenter.daysOfTheWeekModel.groupId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(child: Text('Loading...'));
              return Column(
                children: <Widget>[
                  Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(EgeHelper.plus),
                              color: Colors.indigo,
                              onPressed: () {
                                _showMyDialog();
                              },
                            ),
                          )
                        ],
                      ),
                      flex: 1),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) {
                            return Card(
                              child: Text(
                                  "${snapshot.data.documents[index]["lastname"]} ${snapshot.data.documents[index]["name"]}"),
                            );
                          }),
                      flex: 9)
                ],
              );
            }));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Добавление студента'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Фамилия',
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Имя',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Подтвердить'),
              onPressed: () {
                _groupCreatorPresenter.groupCreatorModel
                    .addNewStudentToTheGroup(_lastNameController.text,
                        _nameController.text, _emailController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
