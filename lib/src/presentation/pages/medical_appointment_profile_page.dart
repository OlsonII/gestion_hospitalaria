import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/infrastructure/utils/global_date.dart';

class MedicalAppointmentProfilePage extends StatelessWidget {

  Radius _standartRadius = Radius.circular(13.0);
  MedicalAppointment _medicalAppointment;

  double _screenWidth;
  double _screenHeight;
  bool _screenLow = false;


  MedicalAppointmentProfilePage(this._medicalAppointment);

  @override
  Widget build(BuildContext context) {

    var _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;
    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

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
      child: _buildMedicalAppointmentProfile(),
    );
  }

  Column _buildMedicalAppointmentProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text('Cita medica', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
        SizedBox(height: 20.0,),
        _buildDoctorInfo(),
        SizedBox(height: 10.0,),
        _buildPatientInfo(),
        SizedBox(height: 10.0,),
        _buildStateInfo(),
        SizedBox(height: 20.0,),
        Center(child: Text('Receta', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
        _buildPrescriptionManager(),
        _buildButtons()
      ],
    );
  }

  Column _buildStateInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Estado', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Text('${_medicalAppointment.state}'),
          Text('Fecha: ${globalDate.formatDate(_medicalAppointment.date)}')
        ],
      );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCompleteButton(),
        SizedBox(width: 10),
        _buildPostponeButton(),
        SizedBox(width: 10),
        _buildCancelButton()
      ],
    );
  }

  Expanded _buildPrescriptionManager() {
    return Expanded(
          child: Row(
            children: [
              _buildPrescriptionTable(),
              SizedBox(width: 20.0,),
              _buildAddMedicineButton()
            ],
          ),
        );
  }

  Container _buildCancelButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: Color.fromRGBO(251, 139, 142, 1)
      ),
      child: FlatButton(
        child: !_screenLow ? Text('Cancelar',
            style: TextStyle(fontSize: 15.0, color: Colors.white)) :
        FaIcon(FontAwesomeIcons.ban, color: Colors.white),
        onPressed: (){

        },
      ),
    );
  }

  Container _buildPostponeButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: Color.fromRGBO(255, 188, 132, 1)
      ),
      child: FlatButton(
        child: !_screenLow ? Text('Postponer',
            style: TextStyle(fontSize: 15.0, color: Colors.white)) :
        FaIcon(FontAwesomeIcons.solidClock, color: Colors.white),
        onPressed: (){
        },
      ),
    );
  }

  Container _buildCompleteButton() {
    return Container(
//                        width: _screenWidth*0.11,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: Color.fromRGBO(171, 208, 188, 1)
      ),
      child: FlatButton(
        child: !_screenLow ? Text('Completar',
            style: TextStyle(fontSize: 15.0, color: Colors.white)) :
        FaIcon(FontAwesomeIcons.check, color: Colors.white),
        onPressed: (){
        },
      ),
    );
  }

  Expanded _buildPrescriptionTable() {
    return Expanded(
        child: Container(
          child: DataTable(
              columns: [new DataColumn(label: Text('Medicamento', style: TextStyle(fontWeight: FontWeight.bold))), new DataColumn(label: Text('Cantidad', style: TextStyle(fontWeight: FontWeight.bold)))],
              rows: [/*new DataRow(cells: [DataCell(Text('null')), DataCell(Text('null'))])*/]
          ),
        )
    );
  }

  Container _buildAddMedicineButton() {
    return Container(
      width: _screenWidth*0.05,
      height: _screenHeight*0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: Color.fromRGBO(171, 208, 188, 1)
      ),
      child: FlatButton(
        child: FaIcon(FontAwesomeIcons.plus, color: Colors.white, size: 15.0,),
        onPressed: (){
        },
      ),
    );
  }

  Column _buildPatientInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Paciente', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
        Text('Identificacion: ${_medicalAppointment.patient.identification}'),
        Text('Nombre: ${_medicalAppointment.patient.name} ${_medicalAppointment.patient.surname}'),
        Text('Genero: ${_medicalAppointment.patient.gender}'),
        Text('EPS: ${_medicalAppointment.patient.eps}'),
        Text('Estrato: ${_medicalAppointment.patient.stratum}'),
      ],
    );
  }

  Column _buildDoctorInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Doctor', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
        Text('Nombre: ${_medicalAppointment.doctor.name} ${_medicalAppointment.doctor.surname}'),
        Text('Titulo: ${_medicalAppointment.doctor.degree}'),
      ],
    );
  }
}