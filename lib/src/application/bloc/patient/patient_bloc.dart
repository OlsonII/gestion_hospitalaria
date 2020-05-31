import 'dart:async';

import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_state.dart';
import 'package:gestion_hospitalaria/src/infrastructure/repositories/patient_repository.dart';

class PatientBloc{

  final _patientRepository = PatientRepository();

  StreamController<PatientEvent> _patientInput = StreamController();
  StreamController<PatientState> _patientOutput = StreamController.broadcast();

  Stream<PatientState> get patientStream => _patientOutput.stream;
  StreamSink<PatientEvent> get sendPatientEvent => _patientInput.sink;

  PatientBloc(){
    _patientInput.stream.listen(_onEvent);
  }

  void dispose(){
    _patientInput.close();
    _patientOutput.close();
  }

  void _onEvent(PatientEvent event) async {
    if(event is SearchPatient){
      _patientOutput.add(PatientLoaded(patient: await _patientRepository.getSpecifyPatient(event.patient.identification)));
    }else if(event is RegisterPatient){
      var response =  await _patientRepository.createPatient(event.patient);
      print('response $response');
      _patientOutput.add(PatientRegistered(response: response));
    }else if(event is SearchAllPatients){
      _patientOutput.add(PatientsLoaded(patients: await _patientRepository.getAllPatients()));
    }
  }
}

final patientBloc = PatientBloc();