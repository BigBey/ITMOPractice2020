
class Student{
  String _id;
  String _name;
  bool _visit;

  String get id => _id;
  String get name => _name;
  bool get visit => _visit;
  set visit(bool value) {
    _visit = value;
  }

  Student(this._id, this._name, this._visit);
}