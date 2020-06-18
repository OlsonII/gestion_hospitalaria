
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_exam.dart';

abstract class MedicalExamState{}

class MedicalExamEmpty extends MedicalExamState{
  final List<MedicalExam> medicalExams = [];

  List<Object> get props => [medicalExams];
}

class MedicalExamLoading extends MedicalExamState{}

class MedicalExamsLoaded extends MedicalExamState {

  final List<MedicalExam> medicalExams;

  MedicalExamsLoaded({@required this.medicalExams}) : assert(medicalExams != null);

  List<Object> get props => [medicalExams];
}

class MedicalExamLoaded extends MedicalExamState {

  final MedicalExam medicalExam;

  MedicalExamLoaded({@required this.medicalExam}) : assert(medicalExam != null);

  List<Object> get props => [medicalExam];
}

class MedicalExamRegistered extends MedicalExamState {

  final String response;

  MedicalExamRegistered({@required this.response}) : assert(response != null);

  List<Object> get props => [response];
}

class MedicalAppointmentsError extends MedicalExamState {}