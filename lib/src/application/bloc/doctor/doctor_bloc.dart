

import 'dart:async';

import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';
import 'package:gestion_hospitalaria/src/infrastructure/repositories/doctor_repository.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorBloc{

  final _doctorRepository = DoctorRepository();

  StreamController<DoctorEvent> _doctorInput = StreamController();
  StreamController<DoctorState> _doctorOutput = StreamController.broadcast();

  Stream<DoctorState> get doctorStream => _doctorOutput.stream;
  StreamSink<DoctorEvent> get sendDoctorEvent => _doctorInput.sink;

  DoctorBloc(){
    _doctorInput.stream.listen(_onEvent);
  }

  void dispose(){
    _doctorInput.close();
    _doctorOutput.close();
  }

  void _onEvent(DoctorEvent event) async {
    if(event is SearchDoctor){
      _doctorOutput.add(DoctorLoaded(doctor: await _doctorRepository.getSpecifyDoctor(event.doctor.id)));
    }else if(event is SearchAllDoctors){
      _doctorOutput.add(DoctorsLoaded(doctors: await _doctorRepository.getAllDoctors()));
    }
  }
}

final doctorBloc = DoctorBloc();