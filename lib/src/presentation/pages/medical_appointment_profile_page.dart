import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';

class MedicalAppointmentProfilePage extends StatelessWidget {

  Radius _standartRadius = Radius.circular(13.0);
  MedicalAppointment _medicalAppointment;


  MedicalAppointmentProfilePage(this._medicalAppointment);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Cita medica', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
          SizedBox(height: 20.0,),
          Text('Doctor', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Text('Nombre: ${_medicalAppointment.doctor.name} ${_medicalAppointment.doctor.surname}'),
          Text('Titulo: ${_medicalAppointment.doctor.degree}'),
          SizedBox(height: 10.0,),
          Text('Paciente', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Text('Identificacion: ${_medicalAppointment.patient.identification}'),
          Text('Nombre: ${_medicalAppointment.patient.name} ${_medicalAppointment.patient.surname}'),
          Text('EPS: ${_medicalAppointment.patient.eps}'),
          Text('Estrato: ${_medicalAppointment.patient.stratum}'),
          SizedBox(height: 10.0,),
          Text('Estado', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Text('${_medicalAppointment.state}'),
          SizedBox(height: 20.0,),
          Center(child: Text('Receta', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}