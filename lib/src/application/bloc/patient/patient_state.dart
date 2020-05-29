import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';

abstract class PatientState{}

class PatientsEmpty extends PatientState{
  final List<Patient> patients = [];

  List<Object> get props => [patients];
}

class PatientsLoading extends PatientState{}

class PatientRegistered extends PatientState {

  final String response;

  PatientRegistered({@required this.response}) : assert(response != null);

  List<Object> get props => [response];
}

class PatientLoaded extends PatientState {

  final Patient patient;

  PatientLoaded({@required this.patient}) : assert(patient != null);

  List<Object> get props => [patient];
}

class PatientsLoaded extends PatientState {

  final List<Patient> patients;

  PatientsLoaded({@required this.patients}) : assert(patients != null);

  List<Object> get props => [patients];
}

class DoctorsError extends PatientState {}