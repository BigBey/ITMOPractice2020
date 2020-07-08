import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/GroupCreator/entities/Student.dart';
import 'package:flutterapp/GroupCreator/presenter/GroupCreatorPresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                .orderBy("lastname")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(child: Text('Loading...'));
              return Column(
                children: <Widget>[
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              onPressed: () {
                                _groupCreatorPresenter.goBack(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: _groupCreatorPresenter.mainPresenter
                                    .mainPresenterModel.themeColorEnd,
                              ),
                              iconSize: 40.0,
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(EgeHelper.plus),
                              color: _groupCreatorPresenter.mainPresenter
                                  .mainPresenterModel.themeColorEnd,
                              iconSize: 40.0,
                              onPressed: () {
                                _showMyDialog();
                              },
                            ),
                          )
                        ],
                      ),
                      flex: 2),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Список группы",
                        style: TextStyle(
                            color: _groupCreatorPresenter
                                .mainPresenter.mainPresenterModel.themeColorEnd,
                            fontSize: 20),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) {
                            return Container(
                                height: 50,
                                width: 100,
                                child: Card(
                                    color: _groupCreatorPresenter.mainPresenter
                                        .mainPresenterModel.themeColorEnd,
                                    child: Center(
                                      child: Text(
                                        "${snapshot.data.documents[index]["lastname"]} ${snapshot.data.documents[index]["name"]}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )));
                          }),
                      flex: 10)
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
              onPressed: () async {
                FlutterToast.showToast(
                  msg: await _groupCreatorPresenter.groupCreatorModel
                      .addNewStudentToTheGroup(_lastNameController.text,
                      _nameController.text, _emailController.text),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
