import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catalog/presenter/CatalogPresenter.dart';
import 'package:flutterapp/Catalog/view/VariantItem.dart';
import 'package:flutterapp/liquid_progress_indicator/liquid_progress_indicator.dart';

class CatalogView extends StatefulWidget {
  var _catalogPresenter;

  CatalogView(CatalogPresenter catalogPresenter) {
    this._catalogPresenter = catalogPresenter;
  }

  @override
  State<StatefulWidget> createState() => CatalogViewState(_catalogPresenter);
}

class CatalogViewState extends State<CatalogView> {
  var _catalogPresenter;
  List<bool> _isSelected;
  int _fIndex = 0;
  var fragments = new List<Widget>(2);

  CatalogViewState(CatalogPresenter catalogPresenter) {
    _catalogPresenter = catalogPresenter;
    fragments[0] = this._catalogPresenter.groupsPresenter.groupsView;
    fragments[1] = this._catalogPresenter.tasksPresenter.tasksView;
  }

  @override
  void initState() {
    _isSelected = [true, false];
    super.initState();
  }

  Widget createFirstElement(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: IconButton(
                    color: _catalogPresenter
                        .mainPresenter.mainPresenterModel.themeColorEnd,
                    icon: Icon(Icons.highlight_off),
                    iconSize: 30,
                    onPressed: () {
                      this._catalogPresenter.goBack(context);
                    },
                  ),
                  padding: EdgeInsets.only(left: 15),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: (_catalogPresenter.state == "Teacher")
                      ? FutureBuilder(
                          future: _catalogPresenter.catalogModel
                              .getTeacherName(_catalogPresenter.userId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                "Loading...",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                            return Text(
                              snapshot.data,
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        )
                      : FutureBuilder(
                          future: _catalogPresenter.catalogModel
                              .getStudentName(_catalogPresenter.userId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                "Loading...",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                            return Text(
                              snapshot.data,
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: _catalogPresenter
                        .mainPresenter.mainPresenterModel.themeColorEnd,
                    border: new Border(),
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0)),
                  ),
                  width: 100,
                  height: 40,
                )
              ],
            ),
          ]),
    );
  }

  Widget createSecondElement() {
    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Container(
          child: ToggleButtons(
            borderRadius: BorderRadius.all(Radius.circular(80)),
            borderColor: Colors.white70,
            fillColor: _catalogPresenter
                .mainPresenter.mainPresenterModel.themeColorEnd,
            selectedColor: Colors.white,
            children: <Widget>[
              Container(
                  width: 150,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Текущие',
                          style: TextStyle(fontSize: 20),
                        ),
                      ))),
              Container(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Добавить',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                _fIndex = index;
                for (int buttonIndex = 0;
                    buttonIndex < _isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    _isSelected[buttonIndex] = true;
                  } else {
                    _isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: _isSelected,
          ),
        ));
  }

  //

  @override
  Widget build(BuildContext context) {
    switch(_catalogPresenter.state){
      case "Teacher":
        return Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            createFirstElement(context),
            createSecondElement(),
            Container(height: (_fIndex == 0)? 492 : 299,child:fragments[_fIndex])
          ]),
        );
        break;
      case "Student":
        return Scaffold(
          body: Column(children: <Widget>[
            new Expanded(child: createFirstElement(context), flex: 3),
            new Expanded(child: FutureBuilder(
              future: _catalogPresenter.catalogModel.getStudentGroup(_catalogPresenter.userId),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                _catalogPresenter.mainPresenter.daysOfTheWeekPresenter.daysOfTheWeekModel.groupId = snapshot.data;
                return _catalogPresenter.mainPresenter.daysOfTheWeekPresenter.daysOfTheWeekView;
              },
            ), flex: 26),
          ]),
        );
    }
  }
}
