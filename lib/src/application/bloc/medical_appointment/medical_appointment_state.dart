
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';

abstract class MedicalAppointmentState{}

class MedicalAppointmentEmpty extends MedicalAppointmentState{
  final List<MedicalAppointment> medicalAppointment = [];

  List<Object> get props => [medicalAppointment];
}

class MedicalAppointmentsLoading extends MedicalAppointmentState{}

class MedicalAppointmentsLoaded extends MedicalAppointmentState {

  final List<MedicalAppointment> medicalAppointment;

  MedicalAppointmentsLoaded({@required this.medicalAppointment}) : assert(medicalAppointment != null);

  List<Object> get props => [medicalAppointment];
}

class MedicalAppointmentLoaded extends MedicalAppointmentState {

  final MedicalAppointment medicalAppointment;

  MedicalAppointmentLoaded({@required this.medicalAppointment}) : assert(medicalAppointment != null);

  List<Object> get props => [medicalAppointment];
}

class MedicalAppointmentsError extends MedicalAppointmentState {}