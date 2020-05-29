
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';

abstract class DoctorEvent extends Equatable{
  const DoctorEvent();
}

class registerDoctor extends DoctorEvent {

  final Doctor doctor;

  const registerDoctor({@required this.doctor}) : assert(doctor != null);

  @override
  List<Object> get props => [doctor];

}

class SearchDoctor extends DoctorEvent {

  final Doctor doctor;

  const SearchDoctor({@required this.doctor}) : assert(doctor != null);

  @override
  List<Object> get props => [doctor];

}

class SearchAllDoctors extends DoctorEvent {

  final List<Doctor> doctors = [];

  @override
  List<Object> get props => [doctors];

}