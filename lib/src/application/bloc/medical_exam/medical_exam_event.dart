
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_exam.dart';

abstract class MedicalExamEvent extends Equatable{
  const MedicalExamEvent();
}

class RegisterMedicalExamEvent extends MedicalExamEvent {

  final MedicalExam medicalExam;

  const RegisterMedicalExamEvent({@required this.medicalExam}) : assert(medicalExam != null);

  @override
  List<Object> get props => [medicalExam];

}

class SearchMedicalExamEvent extends MedicalExamEvent {

  final String personId;

  const SearchMedicalExamEvent({@required this.personId}) : assert(personId != null);

  @override
  List<Object> get props => [personId];

}

class SearchAllMedicalExamEvent extends MedicalExamEvent {

  final List<MedicalExam> medicalExams = [];

  @override
  List<Object> get props => [medicalExams];

}

class CancelMedicalExamEvent extends MedicalExamEvent {

  final MedicalExam medicalExam;

  const CancelMedicalExamEvent({@required this.medicalExam}) : assert(medicalExam != null);

  @override
  List<Object> get props => [medicalExam];

}

class CompleteMedicalExamEvent extends MedicalExamEvent {

  final MedicalExam medicalExam;

  const CompleteMedicalExamEvent({@required this.medicalExam}) : assert(medicalExam != null);

  @override
  List<Object> get props => [medicalExam];

}

class PostponeMedicalExamEvent extends MedicalExamEvent {

  final MedicalExam medicalExam;

  const PostponeMedicalExamEvent({@required this.medicalExam}) : assert(medicalExam != null);

  @override
  List<Object> get props => [medicalExam];

}