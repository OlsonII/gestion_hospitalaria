
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
    }
  }

}

final medicalAppointmentBloc = MedicalAppointmentBloc();