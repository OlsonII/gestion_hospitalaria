import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medicine.dart';
import 'package:gestion_hospitalaria/src/domain/entities/prescription.dart';
import 'package:gestion_hospitalaria/src/infrastructure/utils/global_date.dart';

import 'home_page.dart';

class MedicalAppointmentProfilePage extends StatefulWidget {

  MedicalAppointment _medicalAppointment;


  MedicalAppointmentProfilePage(this._medicalAppointment);

  @override
  _MedicalAppointmentProfilePageState createState() => _MedicalAppointmentProfilePageState();
}

class _MedicalAppointmentProfilePageState extends State<MedicalAppointmentProfilePage> {
  Radius _standartRadius = Radius.circular(13.0);

  double _screenWidth;

  double _screenHeight;

  bool _screenLow = false;

  @override
  Widget build(BuildContext context) {

    var _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;
    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

    if(widget._medicalAppointment.prescription == null){
      widget._medicalAppointment.prescription = new Prescription();
      widget._medicalAppointment.prescription.creationDate = DateTime.now();
      widget._medicalAppointment.prescription.expirationDate = DateTime.now().add(Duration(days: 15));
      widget._medicalAppointment.prescription.state = 'Facturada';
      widget._medicalAppointment.prescription.medicines = new List();
    }


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
          Text('${widget._medicalAppointment.state}'),
          Text('Fecha: ${globalDate.formatDate(widget._medicalAppointment.date)}')
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
          color: widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          Color.fromRGBO(251, 139, 142, 1) : Colors.grey
      ),
      child: FlatButton(
        child: !_screenLow ? Text('Cancelar',
            style: TextStyle(fontSize: 15.0, color: Colors.white)) :
        FaIcon(FontAwesomeIcons.ban, color: Colors.white),
        onPressed: (){
          widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          actionInfoDialog(context, 'Cancelar') : (){};
        },
      ),
    );
  }

  Container _buildPostponeButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          Color.fromRGBO(255, 188, 132, 1) : Colors.grey
      ),
      child: FlatButton(
        child: !_screenLow ? Text('Postponer',
            style: TextStyle(fontSize: 15.0, color: Colors.white)) :
        FaIcon(FontAwesomeIcons.solidClock, color: Colors.white),
        onPressed: (){
          widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          (){} : (){};
        },
      ),
    );
  }

  Container _buildCompleteButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          Color.fromRGBO(171, 208, 188, 1) : Colors.grey
      ),
      child: FlatButton(
        child: !_screenLow ? Text('Completar',
            style: TextStyle(fontSize: 15.0, color: Colors.white)) :
        FaIcon(FontAwesomeIcons.check, color: Colors.white),
        onPressed: (){
          widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
            actionInfoDialog(context, 'Completar')
              : (){};
        },
      ),
    );
  }

  Expanded _buildPrescriptionTable() {
    return Expanded(
        child: Container(
          child: DataTable(
              columns: [new DataColumn(label: Text('Medicamento', style: TextStyle(fontWeight: FontWeight.bold))), new DataColumn(label: Text('Cantidad', style: TextStyle(fontWeight: FontWeight.bold)))],
              rows: mapRowsToTable()
          ),
        )
    );
  }

  mapRowsToTable(){
    if(widget._medicalAppointment.prescription.medicines == null)
      return [];

    List<DataRow> rows = new List();
    widget._medicalAppointment.prescription.medicines.forEach((element) {
      rows.add(new DataRow(cells: [DataCell(Text('${element.name}')), DataCell(Text('${element.quantity}'))]));
    });

    return rows;
  }

  actionInfoDialog(BuildContext context, String action){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('$action de cita medica', style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Esta seguro de $action esta cita medica?'),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Aceptar'),
                onPressed: (){
                  Navigator.of(context).pop();
                  switch(action){
                    case 'Cancelar':
                      setState(() {
                        medicalAppointmentBloc.sendMedicalAppointmentEvent.add(CancelMedicalAppointmentEvent(medicalAppointment: widget._medicalAppointment));
                        if(_showResponse('cancelada'))
                          widget._medicalAppointment.state = 'Cancelada';
                      });
                      break;
                    case 'Completar':
                      medicalAppointmentBloc.sendMedicalAppointmentEvent.add(CompleteMedicalAppointmentEvent(medicalAppointment: widget._medicalAppointment));
                      _showResponse(action);
                      break;
                  }
                },
              )
            ],
          );
        }
    );
  }

  _showResponse(String action){
    medicalAppointmentBloc.medicalAppointmentStream.forEach((element) {
      if(element is MedicalAppointmentRegistered){
        if(element.response == 'Cita medica $action satisfactoriamente'){
          _registeredMedicalAppointmentDialog(context, element.response);
          return true;
        }
        _registeredMedicalAppointmentDialog(context, element.response);
      }
      return false;
    });
  }

  _registeredMedicalAppointmentDialog(BuildContext context, response){

    if(response == 'Cita medica completada satisfactoriamente'){
      setState(() {
        widget._medicalAppointment.state = 'completada';
      });
    }


    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Respuesta', style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('$response'),
            actions: [
              FlatButton(
                child: Text('Cerrar'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        }
    );
  }

  Container _buildAddMedicineButton() {
    Medicine medicine = new Medicine();
    return Container(
      width: _screenWidth*0.05,
      height: _screenHeight*0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standartRadius),
          color: widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          Color.fromRGBO(171, 208, 188, 1) : Colors.grey
      ),
      child: FlatButton(
        child: FaIcon(FontAwesomeIcons.plus, color: Colors.white, size: 15.0,),
        onPressed: (){
          widget._medicalAppointment.state != 'Cancelada' && widget._medicalAppointment.state != 'Completada' ?
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Registrar Medicina'),
                  content: Row(
                    children: [
                      SizedBox(
                        width: _screenWidth*0.2,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: FaIcon(FontAwesomeIcons.capsules),
                            labelText: 'Medicamento*',
                            hintText: 'Ingrese nombre del medicamento aqui',
                          ),
                          onChanged: (value){
                            medicine.name = value;
                          },
                        ),
                      ),
                      SizedBox(width: _screenWidth*0.05,),
                      SizedBox(
                        width: _screenWidth*0.2,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: FaIcon(FontAwesomeIcons.sortNumericDown),
                            labelText: 'Cantidad*',
                            hintText: 'Ingrese la cantidad del medicamento aqui',
                          ),
                          onChanged: (value){
                            medicine.quantity = int.parse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    FlatButton(
                      child: Text('Registrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          widget._medicalAppointment.prescription.medicines.add(medicine);
                        });
                      },
                    )
                  ],
                );
              }
          ) : (){};
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
        Text('Identificacion: ${widget._medicalAppointment.patient.identification}'),
        Text('Nombre: ${widget._medicalAppointment.patient.name} ${widget._medicalAppointment.patient.surname}'),
        Text('Genero: ${widget._medicalAppointment.patient.gender}'),
        Text('EPS: ${widget._medicalAppointment.patient.eps}'),
        Text('Estrato: ${widget._medicalAppointment.patient.stratum}'),
      ],
    );
  }

  Column _buildDoctorInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Doctor', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
        Text('Nombre: ${widget._medicalAppointment.doctor.name} ${widget._medicalAppointment.doctor.surname}'),
        Text('Titulo: ${widget._medicalAppointment.doctor.degree}'),
      ],
    );
  }
}