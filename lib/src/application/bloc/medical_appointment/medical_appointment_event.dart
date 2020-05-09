
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';

abstract class MedicalAppointmentEvent extends Equatable{
  const MedicalAppointmentEvent();
}

class CreateMedicalAppointmentEvent extends MedicalAppointmentEvent {

  final MedicalAppointment medicalAppointment;

  const CreateMedicalAppointmentEvent({@required this.medicalAppointment}) : assert(medicalAppointment != null);

  @override
  List<Object> get props => [medicalAppointment];

}

class SearchMedicalAppointmentEvent extends MedicalAppointmentEvent {

  final MedicalAppointment medicalAppointment;

  const SearchMedicalAppointmentEvent({@required this.medicalAppointment}) : assert(medicalAppointment != null);

  @override
  List<Object> get props => [medicalAppointment];

}

class SearchAllMedicalAppointmentEvent extends MedicalAppointmentEvent {

  final List<MedicalAppointment> medicalAppointments = [];

  @override
  List<Object> get props => [medicalAppointments];

}