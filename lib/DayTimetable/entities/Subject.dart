
class Subject{
  String _title;
  String _teacherName;
  String _textBook;
  String _textBookRef;
  String _description;
  String _homework;


  String get title => _title;
  String get teacherName => _teacherName;
  String get textBook => _textBook;
  String get homework => _homework;
  String get description => _description;
  String get textBookRef => _textBookRef;

  Subject(this._title, this._teacherName, this._textBook, this._textBookRef,
      this._description, this._homework);
}