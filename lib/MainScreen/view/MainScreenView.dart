import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/MainScreen/presenter/MainScreenPresenter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainScreenView extends StatelessWidget {
  var _mainScreenPresenter;

  MainScreenView.presenter(MainScreenPresenter mainScreenPresenter) {
    this._mainScreenPresenter = mainScreenPresenter;
  }

  MainScreenView() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(_mainScreenPresenter),
    );
  }
}

class HomePage extends StatefulWidget {
  var _mainScreenPresenter;

  HomePage(MainScreenPresenter mainScreenPresenter) {
    this._mainScreenPresenter = mainScreenPresenter;
  }

  @override
  State<StatefulWidget> createState() => _HomePageState(_mainScreenPresenter);
}

class _HomePageState extends State<HomePage> {
  var _mainScreenPresenter;
  TextEditingController _lastNameController;
  TextEditingController _nameController;

  _HomePageState(this._mainScreenPresenter);

  @override
  void initState() {
    super.initState();
    _lastNameController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xff1e51a4), Color(0xff1e51a4)])),
        child: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      "Авторизация",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    padding: EdgeInsets.only(top: 30),
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      _mainScreenPresenter.setAppState(context, "Student");
                      _showMyDialog();
                    },
                    child: Text(
                      "Войти как студент",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      _mainScreenPresenter.setAppState(context, "Teacher");
                      _showMyDialog();
                    },
                    child: Text(
                      "Войти как преподаватель",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Авторизация как ${(_mainScreenPresenter.mainPresenter.catalogPresenter.state == "Student") ? "студент" : "преподаватель"}'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Фамилия',
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Имя',
                      ),
                    )),
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
                String userId = null;
                switch (
                    _mainScreenPresenter.mainPresenter.catalogPresenter.state) {
                  case "Student":
                    try {
                      userId = await _mainScreenPresenter.checkIfStudentExists(
                          _lastNameController.text, _nameController.text);
                    } catch (e) {
                      FlutterToast.showToast(
                        msg: "Неверное имя или фамилия, попробуйте еще раз",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                      print(e.toString());
                    }
                    break;
                  case "Teacher":
                    try {
                      userId = await _mainScreenPresenter.checkIfTeacherExists(
                          _lastNameController.text, _nameController.text);
                    } catch (e) {
                      FlutterToast.showToast(
                        msg: "Неверное имя или фамилия, попробуйте еще раз",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                      print(e.toString());
                    }
                    break;
                }
                if (userId != null) {
                  //_lastNameController.clear();
                  //_nameController.clear();
                  _mainScreenPresenter.mainPresenter.catalogPresenter.userId =
                      userId;
                  _mainScreenPresenter.goToCatalog(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
