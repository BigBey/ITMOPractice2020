import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';
import 'package:flutterapp/days_of_week/presenter/DaysOfTheWeekPresenter.dart';

class DaysOfTheWeekView extends StatelessWidget {
  var _daysOfTheWeekPresenter;

  DaysOfTheWeekView(DaysOfTheWeekPresenter daysOfTheWeekPresenter) {
    _daysOfTheWeekPresenter = daysOfTheWeekPresenter;
  }

  @override
  Widget build(BuildContext context) {
    switch (_daysOfTheWeekPresenter.mainPresenter.catalogPresenter.state) {
      case "Teacher":
        return Scaffold(
            body: Column(
          children: <Widget>[
            new Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: IconButton(
                      onPressed: () {
                        _daysOfTheWeekPresenter.goBack(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                      ),
                      iconSize: 40.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: FlatButton(
                      onPressed: () {
                        _daysOfTheWeekPresenter.goToGroupCreator(context);
                      },
                      child: Text(
                        "Список группы",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: _daysOfTheWeekPresenter
                          .mainPresenter.mainPresenterModel.themeColorEnd,
                    ),
                  )
                ],
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Понедельник",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Понедельник";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Вторник",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Вторник";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Среда",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Среда";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Четверг",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Четверг";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Пятница",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Пятница";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Суббота",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Суббота";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
          ],
        ));
        break;
      case "Student":
        return Scaffold(
            body: Column(
          children: <Widget>[
            new Expanded(
              child: Center(
                child: Text(
                  "Расписание",
                  style: TextStyle(
                      color: _daysOfTheWeekPresenter
                          .mainPresenter.mainPresenterModel.themeColorEnd,
                  fontSize: 25),
                ),
              ),
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Понедельник",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Понедельник";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Вторник",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Вторник";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Среда",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Среда";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Четверг",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Четверг";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Пятница",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Пятница";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
            new Expanded(
              child: FlatButton(
                child: Container(
                    height: 200,
                    width: 400,
                    child: Card(
                        color: _daysOfTheWeekPresenter
                            .mainPresenter.mainPresenterModel.themeColorEnd,
                        child: Center(
                            child: Text(
                          "Суббота",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )))),
                onPressed: () {
                  _daysOfTheWeekPresenter.mainPresenter.dayTimetablePresenter
                      .dayTimetableModel.dayOfTheWeek = "Суббота";
                  _daysOfTheWeekPresenter.goToDayTimetable(context);
                },
              ),
              flex: 1,
            ),
          ],
        ));
        break;
    }
  }
}
