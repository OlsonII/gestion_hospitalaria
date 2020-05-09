import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';

class MedicalAppointmentsPage extends StatelessWidget {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    medicalAppointmentBloc.sendMedicalAppointmentEvent.add(SearchAllMedicalAppointmentEvent());
    return Container();
  }
}
