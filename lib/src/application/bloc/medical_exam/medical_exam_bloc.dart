
import 'dart:async';

import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_exam/medical_exam_state.dart';
import 'package:gestion_hospitalaria/src/infrastructure/repositories/medical_appointment_repository.dart';
import 'package:gestion_hospitalaria/src/infrastructure/repositories/medical_exam_repository.dart';

import 'medical_exam_event.dart';

class MedicalExamBloc{

  final _medicalExamRepository = MedicalExamRepository();

  StreamController<MedicalExamEvent> _medicalExamInput = StreamController();
  StreamController<MedicalExamState> _medicalExamOutput = StreamController.broadcast();

  Stream<MedicalExamState> get medicalExamStream => _medicalExamOutput.stream;
  StreamSink<MedicalExamEvent> get sendMedicalExamEvent => _medicalExamInput.sink;

  MedicalExamBloc(){
    _medicalExamInput.stream.listen(_onEvent);
  }

  void dispose(){
    _medicalExamInput.close();
    _medicalExamOutput.close();
  }

  void _onEvent(MedicalExamEvent event) async {
    if(event is SearchAllMedicalExamEvent){
      _medicalExamOutput.add(MedicalExamsLoaded(medicalExams: await _medicalExamRepository.searchAllMedicalExams()));
    }else if(event is RegisterMedicalExamEvent){
      _medicalExamOutput.add(MedicalExamRegistered(response: await _medicalExamRepository.createMedicalExam(event.medicalExam)));
    }else if(event is SearchMedicalExamEvent){
      _medicalExamOutput.add(MedicalExamsLoaded(medicalExams: await _medicalExamRepository.getSpecifyMedicalExam(event.personId)));
    }else if(event is CancelMedicalExamEvent){
      var response = await _medicalExamRepository.cancelMedicalExam(event.medicalExam);
      _medicalExamOutput.add(MedicalExamRegistered(response: response));
    }else if(event is CompleteMedicalExamEvent){
      var response = await _medicalExamRepository.completeMedicalExam(event.medicalExam);
      _medicalExamOutput.add(MedicalExamRegistered(response: response));
    }
  }

}

final medicalExamBloc = MedicalExamBloc();