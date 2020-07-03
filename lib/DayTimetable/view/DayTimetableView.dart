
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/DayTimetable/presenter/DayTimetablePresenter.dart';

class DayTimetableView extends StatefulWidget{
  var _dayTimetablePresenter;


  DayTimetableView(DayTimetablePresenter dayTimetablePresenter){
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  State<StatefulWidget> createState() => DayTimetableViewState(_dayTimetablePresenter);

}

class DayTimetableViewState extends State<DayTimetableView>{
  var _dayTimetablePresenter;


  DayTimetableViewState(DayTimetablePresenter dayTimetablePresenter){
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}