import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/MainPresenter/MainPresenter.dart';
import 'package:flutterapp/MainScreen/view/MainScreenView.dart';

class MainScreenPresenter {
  var _mainScreenView;
  var _mainPresenter;

  get mainPresenter => _mainPresenter;

  MainScreenPresenter(MainPresenter mainPresenter) {
    this._mainPresenter = mainPresenter;
    this._mainScreenView = MainScreenView.presenter(this);
    startMainScreen();
  }

  void startMainScreen() {
    runApp(_mainScreenView);
  }

  void setAppState(BuildContext context, String state) {
    _mainPresenter.catalogPresenter.state = state;
  }

  void goToCatalog(BuildContext context) {
    _mainPresenter.catalogPresenter.loadCatalogModel();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _mainPresenter.mainPresenterView),
    );
  }

  Future<String> checkIfStudentExists(String lastname, String name) {
    try {
      return Firestore.instance
          .collection("Students")
          .where("lastname", isEqualTo: lastname)
          .where("name", isEqualTo: name)
          .getDocuments()
          .then((value) {
        return value.documents[0].documentID;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> checkIfTeacherExists(String lastname, String name) {
    try {
      return Firestore.instance
          .collection("Teachers")
          .where("lastname", isEqualTo: lastname)
          .where("name", isEqualTo: name)
          .getDocuments()
          .then((value) {
        return value.documents[0].documentID;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
