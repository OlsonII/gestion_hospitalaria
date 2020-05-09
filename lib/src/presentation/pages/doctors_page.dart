import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor_event.dart';

class DoctorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    doctorBloc.sendDoctorEvent.add(SearchAllDoctors());
    return Container();
  }
}
