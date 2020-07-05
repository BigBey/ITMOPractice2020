
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';
import 'package:flutterapp/days_of_week/presenter/DaysOfTheWeekPresenter.dart';

class DaysOfTheWeekView extends StatelessWidget{
  var _daysOfTheWeekPresenter;

  DaysOfTheWeekView(DaysOfTheWeekPresenter daysOfTheWeekPresenter){
    _daysOfTheWeekPresenter = daysOfTheWeekPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      _daysOfTheWeekPresenter.goToGroupCreator(context);
                    },
                    child: Text(
                      "Студенты",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.indigo,
                  ),
                )
              ],
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Понедельник"),
              onPressed: (){
                _daysOfTheWeekPresenter.goToDayTimetable(context);
              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Вторник"),
              onPressed: (){
                _daysOfTheWeekPresenter.goToDayTimetable(context);
              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Среда"),
              onPressed: (){
                _daysOfTheWeekPresenter.goToDayTimetable(context);
              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Четверг"),
              onPressed: (){
                _daysOfTheWeekPresenter.goToDayTimetable(context);
              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Пятница"),
              onPressed: (){
                _daysOfTheWeekPresenter.goToDayTimetable(context);
              },
            ),
            flex: 1,
          ),
        ],
      )
    );
  }


}