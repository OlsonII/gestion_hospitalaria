
import 'dart:async';

import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/infrastructure/repositories/medical_appointment_repository.dart';

class MedicalAppointmentBloc{

  final _medicalAppointmentRepository = MedicalAppointmentRepository();

  StreamController<MedicalAppointmentEvent> _medicalAppointmentInput = StreamController();
  StreamController<MedicalAppointmentState> _medicalAppointmentOutput = StreamController.broadcast();

  Stream<MedicalAppointmentState> get medicalAppointmentStream => _medicalAppointmentOutput.stream;
  StreamSink<MedicalAppointmentEvent> get sendMedicalAppointmentEvent => _medicalAppointmentInput.sink;

  MedicalAppointmentBloc(){
    _medicalAppointmentInput.stream.listen(_onEvent);
  }

  void dispose(){
    _medicalAppointmentInput.close();
    _medicalAppointmentOutput.close();
  }

  void _onEvent(MedicalAppointmentEvent event) async {
    if(event is SearchAllMedicalAppointmentEvent){
      _medicalAppointmentOutput.add(MedicalAppointmentsLoaded(medicalAppointments: await _medicalAppointmentRepository.searchAllMedicalAppointments()));
    }else if(event is RegisterMedicalAppointmentEvent){
      _medicalAppointmentOutput.add(MedicalAppointmentRegistered(response: await _medicalAppointmentRepository.createMedicalAppointment(event.medicalAppointment)));
    }else if(event is SearchMedicalAppointmentEvent){
      var response;
      if(event.isPatient){
         response = await _medicalAppointmentRepository.getSpecifyMedicalAppointment(event.personId, true);
      }else{
        response = await _medicalAppointmentRepository.getSpecifyMedicalAppointment(event.personId, false);
      }
      _medicalAppointmentOutput.add(MedicalAppointmentsLoaded(medicalAppointments: response));
    }else if(event is CancelMedicalAppointmentEvent){
      var response = await _medicalAppointmentRepository.cancelMedicalAppointment(event.medicalAppointment);
      _medicalAppointmentOutput.add(MedicalAppointmentRegistered(response: response));
    }else if(event is CompleteMedicalAppointmentEvent){
      var response = await _medicalAppointmentRepository.completeMedicalAppointment(event.medicalAppointment);
      _medicalAppointmentOutput.add(MedicalAppointmentRegistered(response: response));
    }
  }

}

final medicalAppointmentBloc = MedicalAppointmentBloc();