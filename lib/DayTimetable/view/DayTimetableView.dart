import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/DayTimetable/entities/Subject.dart';
import 'package:flutterapp/DayTimetable/presenter/DayTimetablePresenter.dart';
import 'package:flutterapp/assets/ege_helper_icons.dart';

class DayTimetableView extends StatefulWidget {
  var _dayTimetablePresenter;


  DayTimetableView(DayTimetablePresenter dayTimetablePresenter) {
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  State<StatefulWidget> createState() =>
      DayTimetableViewState(_dayTimetablePresenter);

}

class DayTimetableViewState extends State<DayTimetableView> {
  var _dayTimetablePresenter;
  var subjects = List<Subject>();
  TextEditingController _titleController;
  TextEditingController _teacherName;
  TextEditingController _textBook;
  TextEditingController _textBookRef;
  TextEditingController _description;
  TextEditingController _homework;


  DayTimetableViewState(DayTimetablePresenter dayTimetablePresenter) {
    _dayTimetablePresenter = dayTimetablePresenter;
  }

  @override
  void initState() {
    super.initState();
    _dayTimetablePresenter.getSubjectFromDB();
    subjects = _dayTimetablePresenter.subjects;
    _titleController = TextEditingController();
    _teacherName = TextEditingController();
    _textBook = TextEditingController();
    _textBookRef = TextEditingController();
    _description = TextEditingController();
    _homework = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _teacherName.dispose();
    _textBook.dispose();
    _textBookRef.dispose();
    _description.dispose();
    _homework.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            new Expanded(child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        EgeHelper.plus,
                        color: _dayTimetablePresenter.mainPresenter.mainPresenterModel.themeColorEnd,
                      ),
                      onPressed: () {
                        _showMyDialog();
                      },
                    )
                )
              ],
            ),
            flex: 1,),
            new Expanded(child: ListView.builder(
              itemCount: subjects.length,
                itemBuilder: (_, index){
                   return Card(
                     child: Column(
                       children: <Widget>[
                         Text(subjects[index].title),
                         Text(subjects[index].teacherName),
                         Text(subjects[index].textBook),
                         Text(subjects[index].textBookRef),
                         Text(subjects[index].description),
                         Text(subjects[index].homework),
                       ],
                     ),
                   );
                }),
              flex: 9,)
          ],
        )
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Создание занятия'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название занятия',
                  ),
                ),
                TextField(
                  controller: _teacherName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ФИО преподавателя',
                  ),
                ),
                TextField(
                  controller: _textBook,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название учебника',
                  ),
                ),
                TextField(
                  controller: _textBookRef,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ссылка на учебник',
                  ),
                ),
                TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Описание занятия',
                  ),
                ),
                TextField(
                  controller: _homework,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Домашнее задание',
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
                _addItem();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addItem(){
    setState(() {
      subjects.add(
          Subject(
              _titleController.text,
              _teacherName.text,
              _textBook.text,
              _textBookRef.text,
              _description.text,
              _homework.text)
      );
    });
  }

}