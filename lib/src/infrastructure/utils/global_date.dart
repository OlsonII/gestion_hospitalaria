import 'package:intl/intl.dart';

class GlobalDate {

  DateTime _dateSelected;

  GlobalDate() {
    _dateSelected = DateTime.now().add(Duration(days: 1));
  }

  DateTime get dateSelected => _dateSelected;

  set dateSelected (DateTime date){
    _dateSelected = date;
  }

  formatDate(DateTime date){
    return  DateFormat('dd/MM/yyyy').format(date).toString();
  }

  formatHour(DateTime date){
    return DateFormat('hh:mm').format(date).toString();
  }
}

GlobalDate globalDate = new GlobalDate();