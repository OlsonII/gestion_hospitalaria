import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';
import 'package:gestion_hospitalaria/src/infrastructure/utils/global_date.dart';
import 'package:gestion_hospitalaria/src/presentation/loaders/color_progress_indicator.dart';

class PatientProfilePage extends StatelessWidget {

  Radius _standartRadius = Radius.circular(13.0);
  Patient _patient;


  PatientProfilePage(this._patient);

  @override
  Widget build(BuildContext context) {
    medicalAppointmentBloc.sendMedicalAppointmentEvent.add(SearchMedicalAppointmentEvent(personId: _patient.identification, isPatient: true));
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        padding: EdgeInsets.all(35.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(_standartRadius),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
              children: [
                Container(
                    child: _patient.gender == 'Femenino' ?
                    FaIcon(FontAwesomeIcons.venus, color: Colors.pinkAccent, size: 60.0) :
                    FaIcon(FontAwesomeIcons.mars, color: Colors.blueAccent, size: 60.0)
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Identificacion: ${_patient.identification}'),
                    SizedBox(height: 7.0),
                    Text('Nombre: ${_patient.name} ${_patient.surname}'),
                    SizedBox(height: 7.0),
                    Text('Genero: ${_patient.gender}'),
                    SizedBox(height: 7.0),
                    Text('Estrato: ${_patient.stratum} - EPS: ${_patient.eps}')
                  ],
                )
              ]),
          SizedBox(height: 50.0,),
          Center(child: Text('Citas Medicas')),
          SizedBox(height: 50.0,),
          Container(
            child: StreamBuilder(
              stream: medicalAppointmentBloc.medicalAppointmentStream,
              initialData: [],
              builder: (context, snapshot){
                if(snapshot.data is MedicalAppointmentsLoaded){
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.medicalAppointments.length,
                      itemBuilder: (context, item) => _createItemList(context, snapshot.data.medicalAppointments[item])
                  );
                }else{
                  return Center(child: ColorProgressIndicator(color1: Color.fromRGBO(251, 139, 142, 1), color2: Color.fromRGBO(55, 104, 242, 0.5), color3: Color.fromRGBO(78, 76, 173, 1),));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _createItemList(BuildContext context, medicalAppointment) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text('Cita de ${_selectMedicalAppointmentType(medicalAppointment.doctor.degree)}'),
        subtitle: Text('Con ${medicalAppointment.doctor.name} ${medicalAppointment.doctor.surname} ${globalDate.formatDate(medicalAppointment.date)} a las ${globalDate.formatHour(medicalAppointment.hour)}'),
        trailing: Text('${medicalAppointment.state}'),
        onTap: () {
          /*setState(() {
            _pageSelected = MedicalAppointmentProfilePage();
          });*/
        },
      ),
    );
  }

  _selectMedicalAppointmentType(String degree){
    switch(degree){
      case 'Doctor':
        return 'Medicina General';
      case 'Pediatra':
        return 'Pediatria';
      case 'Oftalmologo':
        return 'Oftalmologia';
      case 'Odontologo':
        return 'Odontologia';
    }
  }
}