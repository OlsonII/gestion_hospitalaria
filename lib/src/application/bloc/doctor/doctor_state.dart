

import 'package:flutter/cupertino.dart';
import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';

abstract class DoctorState{}

class DoctorsEmpty extends DoctorState{
  final List<Doctor> doctors = [];

  List<Object> get props => [doctors];
}

class DoctorsLoading extends DoctorState{}

class DoctorsLoaded extends DoctorState {

  final List<Doctor> doctors;

  DoctorsLoaded({@required this.doctors}) : assert(doctors != null);

  List<Object> get props => [doctors];
}

class DoctorLoaded extends DoctorState {

  final Doctor doctor;

  DoctorLoaded({@required this.doctor}) : assert(doctor != null);

  List<Object> get props => [doctor];
}

class DoctorsError extends DoctorState {}