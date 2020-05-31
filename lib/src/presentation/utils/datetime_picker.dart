import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/infrastructure/utils/global_date.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {

  DateTime dateSelected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return _buildDateTimePicker();
  }

  _buildDateTimePicker() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: FlatButton(
            child: Text('${globalDate.formatDate(dateSelected)}', style: TextStyle(fontSize: 17.0, color: Color.fromRGBO(140, 140, 140, 1)),),
          onPressed: (){
            showDatePicker(
                context: HomePage.scaffoldKey.currentContext,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 3),
                lastDate: DateTime(DateTime.now().year + 1)
            ).then((date){
              if(date != null){
                setState(() {
//              chargeBloc.sendChargeEvent.add(GetChargesByDate(date: globalDate.formatDate(date)));
                  globalDate.dateSelected = date;
                  dateSelected = date;
                });
              }
            });
          },
        ),
      ),
    );
  }
}
