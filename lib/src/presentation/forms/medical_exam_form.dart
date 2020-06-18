
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_state.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_exam/medical_exam_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_exam/medical_exam_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_exam/medical_exam_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_exam.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';
import 'package:gestion_hospitalaria/src/infrastructure/utils/global_date.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';
import 'package:gestion_hospitalaria/src/presentation/utils/datetime_picker.dart';

class MedicalExamForm extends StatefulWidget {

  static GlobalKey<FormState> formMedicalAppointmentKey = new GlobalKey<FormState>();

  static String response;

  bool submitForm(BuildContext context){
    if(MedicalExamForm.formMedicalAppointmentKey.currentState.validate()){
      MedicalExamForm.formMedicalAppointmentKey.currentState.save();
      _MedicalExamFormState().registerInfoDialog(context);
    }
  }

  @override
  _MedicalExamFormState createState() => _MedicalExamFormState();
}

class _MedicalExamFormState extends State<MedicalExamForm> {

  static final medicalExam = new MedicalExam();
  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;

  List<String> added = [];

  final _standartRadius = Radius.circular(13.0);

  GlobalKey _dropDownDoctorKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

    return Container(
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
      child: Center(child: _buildForm(context)),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      width: _screenWidth*0.50,
      child: Form(
        key: MedicalExamForm.formMedicalAppointmentKey,
        autovalidate: false,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('Registrar Examen Medico', style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: _screenHeight*0.02),
                _buildPatientField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildPatientField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildDateField(context),
                SizedBox(height: _screenHeight*0.02),
//                _buildHourField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerInfoDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Registro de examen medico', style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Esta seguro de registrar este examen medico?'),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Registrar'),
                onPressed: (){
                  medicalExam.date = globalDate.dateSelected;
                  if(_validateDate(medicalExam.date)){
                    medicalExamBloc.sendMedicalExamEvent.add(RegisterMedicalExamEvent(medicalExam: medicalExam));
                    Navigator.of(context).pop();
                    _showResponse(context);
                  }else{
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Verificar fecha', style: TextStyle(fontWeight: FontWeight.bold),),
                            content: Text('Por favor ingrese una fecha valida'),
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
                },
              )
            ],
          );
        }
    );
  }

  _showResponse(BuildContext context){
    medicalExamBloc.medicalExamStream.forEach((element) {
      if(element is MedicalExamRegistered){
        if(element.response == 'Examen medico creado satisfactoriamente'){
          MedicalExamForm.formMedicalAppointmentKey.currentState.reset();
          _registeredMedicalAppointmentDialog(context/*HomePage.scaffoldKey.currentContext*/, element.response);
          return true;
        }
        _registeredMedicalAppointmentDialog(context/*HomePage.scaffoldKey.currentContext*/, element.response);
      }
      return false;
    });
  }

  _registeredMedicalAppointmentDialog(BuildContext context, response){
    showDialog(
        context: context,
        builder: (context){
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

  _buildNameField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: FaIcon(FontAwesomeIcons.solidUser),
            labelText: 'Examen*',
            hintText: 'Ingrese el nombre del examen aqui',
          ),
          keyboardType: TextInputType.text,
//          validator: (value) => _validatePatientId(value),
          onChanged: (value) {
            medicalExam.name = value;
          },
          onSaved: (value) {
            if(value != null)
              medicalExam.name = value;
          }
      ),
    );
  }

  _buildPatientField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: FaIcon(FontAwesomeIcons.solidUser),
            labelText: 'Paciente*',
            hintText: 'Ingrese numero de identificacion del paciente aqui',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => _validatePatientId(value),
          /*onChanged: (value) {
            MedicalAppointmentForm.medicalAppointment.patient.identification = value;
          },*/
          onSaved: (value) {
            if(value != null)
              medicalExam.patient = new Patient(identification: value);
          }
      ),
    );
  }

  _buildDateField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.notesMedical, color: Color.fromRGBO(140, 140, 140, 1)),
          SizedBox(width: _screenWidth*0.03,),
          Text('Fecha', style: TextStyle(fontSize: 17.0, color: Color.fromRGBO(140, 140, 140, 1)),),
          SizedBox(width: _screenWidth*0.03),
          DateTimePicker()
        ],
      ),
    );
  }

  _validatePatientId(String value) {
    if(value.isEmpty){
      return 'Por favor, digite el numero de identificacion del paciente';
    }
  }

  _validateDate(DateTime date){
    if(date.isBefore(DateTime.now().add(Duration(days: 1))))
      return false;

    return true;
  }
}