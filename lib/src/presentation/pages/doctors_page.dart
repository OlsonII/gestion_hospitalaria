import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_state.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';

class DoctorsPage extends StatelessWidget {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  final _standartRadius = Radius.circular(13.0);

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    doctorBloc.sendDoctorEvent.add(SearchAllDoctors());

    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(_standartRadius),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.07),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: StreamBuilder(
                stream: doctorBloc.doctorStream,
                initialData: [],
                builder: (context, snapshot){
                  if(snapshot.data is DoctorsLoaded){
                    return ListView.builder(
                        itemCount: snapshot.data.doctors.length,
                        itemBuilder: (context, item) => _createItemList(context, snapshot.data.doctors[item])
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(_standartRadius),
                  color: Color.fromRGBO(78, 76, 173, 1)
                ),
                child: FlatButton(
                  child: Text('Registrar medico', style: TextStyle(fontSize: 17.0, color: Colors.white)),
                  onPressed: (){},
                ),
              ),
              SizedBox(
                width: _screenWidth*0.05,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(_standartRadius),
                    color: Color.fromRGBO(251, 139, 142, 1)
                ),
                child: FlatButton(
                  child: Text('Modificar medico', style: TextStyle(fontSize: 17.0, color: Colors.white),),
                  onPressed: (){},
                ),
              ),
            ],
          )
        ],
      ),
    );

  }

  _createItemList(BuildContext context, doctor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text(doctor.name),
        subtitle: Text('${doctor.degree} - ${doctor.workday}'),
      ),
    );
  }
}
