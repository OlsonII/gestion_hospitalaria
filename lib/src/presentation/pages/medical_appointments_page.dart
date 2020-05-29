import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/presentation/loaders/color_progress_indicator.dart';
import 'package:intl/intl.dart';

class MedicalAppointmentsPage extends StatelessWidget {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;
  final _radius = Radius.circular(13.0);

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    _screenWidth < 700 ? _screenLow = true : _screenLow = false;
    medicalAppointmentBloc.sendMedicalAppointmentEvent.add(SearchAllMedicalAppointmentEvent());

    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(_radius),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
//                child: Center(child: ColorProgressIndicator(color1: Color.fromRGBO(251, 139, 142, 1), color2: Color.fromRGBO(55, 104, 242, 0.5), color3: Color.fromRGBO(78, 76, 173, 1),))
              child: StreamBuilder(
                  stream: medicalAppointmentBloc.medicalAppointmentStream,
                  initialData: [],
                  builder: (context, snapshot){
                    if(snapshot.data is MedicalAppointmentsLoaded){
                      return ListView.builder(
                          itemCount: snapshot.data.medicalAppointments.length,
                          itemBuilder: (context, item) => _createItemList(context, snapshot.data.medicalAppointments[item])
                      );
                    }
                    else{
                      return Center(child: ColorProgressIndicator(color1: Color.fromRGBO(251, 139, 142, 1), color2: Color.fromRGBO(55, 104, 242, 0.5), color3: Color.fromRGBO(78, 76, 173, 1),));
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
                    borderRadius: BorderRadius.all(_radius),
                    color: Color.fromRGBO(78, 76, 173, 1)
                ),
                child: FlatButton(
                  child: Text(_screenLow ? 'Registrar' : 'Registrar cita medica', style: TextStyle(fontSize: 17.0, color: Colors.white)),
                  onPressed: (){},
                ),
              ),
              SizedBox(
                width: _screenWidth*0.05,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(_radius),
                    color: Color.fromRGBO(251, 139, 142, 1)
                ),
                child: FlatButton(
                  child: Text(_screenLow ? 'Modificar' :'Modificar cita medica', style: TextStyle(fontSize: 17.0, color: Colors.white),),
                  onPressed: (){},
                ),
              ),
            ],
          )
        ],
      ),
    );

  }

  _createItemList(BuildContext context, MedicalAppointment medicalAppointment) {
    //TODO: DAR FORMATO A LAS FECHAS Y HORAS CORRECTAMENTE
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text('Cita de ${medicalAppointment.doctor.degree} para ${medicalAppointment.patient.name} ${medicalAppointment.patient.surname} '),
        subtitle: Text('Con ${medicalAppointment.doctor.name} ${medicalAppointment.doctor.surname} ${formatDate(medicalAppointment.date)} a las ${formatHour(medicalAppointment.hour)}'),
      ),
    );
  }

  formatDate(DateTime date){
    return DateFormat('dd/MM/yyyy').format(date).toString();
  }

  formatHour(DateTime date){
    return DateFormat('hh:mm').format(date).toString();
  }
}
