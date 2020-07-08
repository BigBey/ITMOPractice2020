import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/Groups/entities/Group.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';

class CatalogModel {
  var _catalogPresenter;
  var _amountOfAnswers = "";
  List<Group> _groups;

  get amountOfAnswers => _amountOfAnswers;

  List<Group> get groups => _groups;

  set amountOfAnswers(value) {
    _amountOfAnswers = value;
  }

  CatalogModel(CatalogPresenter catalogPresenter) {
    _catalogPresenter = catalogPresenter;
    _groups = new List<Group>();
    _groups.add(Group("123", "M32031"));
    _groups.add(Group("123", "M32031"));
    _groups.add(Group("123", "M32031"));
  }

  void initGroups() async {
    return await Firestore.instance
        .collection("Groups")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        print(result.data);
      });
    });
  }

  void addGroup(String groupTitle) {
    //TODO add group to DB using model
    _groups.add(Group("1213", groupTitle));
  }

  Future<String> getStudentName(String userId) {
    try {
      return Firestore.instance
          .collection("Students")
          .document(userId)
          .get()
          .then((value) {
        return "${value.data["lastname"]} ${value.data["name"]}";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getTeacherName(String userId) {
    try {
      return Firestore.instance
          .collection("Teachers")
          .document(userId)
          .get()
          .then((value) {
        return "${value.data["lastname"]} ${value.data["name"]}";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getStudentGroup(String userId) {
    try {
      return Firestore.instance
          .collection("Students")
          .document(userId)
          .get()
          .then((value) {
        return value.data["group_id"];
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
