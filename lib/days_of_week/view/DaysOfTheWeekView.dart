
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/days_of_week/presenter/DaysOfTheWeekPresenter.dart';

class DaysOfTheWeekView extends StatelessWidget{
  var _daysOfTheWeekPresenter;

  DaysOfTheWeekView(DaysOfTheWeekPresenter daysOfTheWeekPresenter){
    _daysOfTheWeekPresenter = daysOfTheWeekPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: <Widget>[
          new Expanded(
            child: FlatButton(
              child: Text("Понедельник"),
              onPressed: (){

              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Вторник"),
              onPressed: (){

              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Среда"),
              onPressed: (){

              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Четверг"),
              onPressed: (){

              },
            ),
            flex: 1,
          ),
          new Expanded(
            child: FlatButton(
              child: Text("Пятница"),
              onPressed: (){

              },
            ),
            flex: 1,
          ),
        ],
      )
    ));
  }


}