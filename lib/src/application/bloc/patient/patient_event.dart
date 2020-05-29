import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';

abstract class PatientEvent extends Equatable{
  const PatientEvent();
}

class RegisterPatient extends PatientEvent {

  final Patient patient;

  const RegisterPatient({@required this.patient}) : assert(patient != null);

  @override
  List<Object> get props => [patient];

}

class SearchAllPatients extends PatientEvent {

  final List<Patient> patients = [];

  @override
  List<Object> get props => [patients];

}

class SearchPatient extends PatientEvent {

  final Patient patient;

  const SearchPatient({@required this.patient}) : assert(patient != null);

  @override
  List<Object> get props => [patient];

}