import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';

class PatientForm extends StatefulWidget {

  static GlobalKey<FormState> formDoctorKey = new GlobalKey<FormState>();

  static final patient = new Patient();
  static String response;

  bool submitForm(BuildContext context){
    if(PatientForm.formDoctorKey.currentState.validate()){
      PatientForm.formDoctorKey.currentState.save();
      _PatientFormState().registerInfoDialog(context);
    }
  }

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;
  String _dropdownGender = 'No especificado';
  String _dropdownStratum = '1';

  final _standartRadius = Radius.circular(13.0);

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
        key: PatientForm.formDoctorKey,
        autovalidate: false,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('Registrar Paciente', style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: _screenHeight*0.02),
                _buildIdentificationField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildNameField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildSurnameField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildAgeField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildGenderField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildEPSField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildStratumField(context),
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
            title: Text('Registro de Paciente', style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Esta seguro de registrar a este paciente?'),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Registrar'),
                onPressed: (){
                  patientBloc.sendPatientEvent.add(RegisterPatient(patient: PatientForm.patient));
                  Navigator.of(context).pop();
                  _showResponse();
                },
              )
            ],
          );
        }
    );
  }

  _showResponse(){
    patientBloc.patientStream.forEach((element) {
      if(element is PatientRegistered){
        if(element.response == 'Paciente registrado satisfactoriamente'){
          PatientForm.formDoctorKey.currentState.reset();
          _registeredDoctorDialog(HomePage.scaffoldKey.currentContext, element.response);
          return true;
        }
      }
      return false;
    });
  }

  _registeredDoctorDialog(BuildContext context, response){
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

  _buildIdentificationField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: FaIcon(FontAwesomeIcons.solidIdCard),
            labelText: 'Identificacion*',
            hintText: 'Ingrese la identifiacion aqui',
          ),
          keyboardType: TextInputType.number,
          validator: (value) => _validateIdentification(value) ,
          onChanged: (value) {
            PatientForm.patient.id = value;
          }
      ),
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
            icon: FaIcon(FontAwesomeIcons.solidIdCard),
            labelText: 'Nombre*',
            hintText: 'Ingrese el nombre aqui',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => _validateName(value),
          onChanged: (value) {
            PatientForm.patient.name = value;
          }
//          onSaved: (value) => doctorName = value
      ),
    );
  }

  _buildSurnameField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: FaIcon(FontAwesomeIcons.solidIdCard),
            labelText: 'Apellido*',
            hintText: 'Ingrese el apellido aqui',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => _validateSurname(value),
          onChanged: (value) {
            PatientForm.patient.surname = value;
          }
//          onSaved: (value) => doctorSurname = value
      ),
    );
  }

  _buildAgeField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: FaIcon(FontAwesomeIcons.solidIdCard),
            labelText: 'Edad*',
            hintText: 'Ingrese la edad aqui en años',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => _validateAge(value),
          onChanged: (value) {
            PatientForm.patient.age = int.parse(value);
          }
//          onSaved: (value) => doctorSurname = value
      ),
    );
  }

  _buildGenderField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.venusMars),
          SizedBox(width: _screenWidth*0.03,),
          Text('Genero'),
          SizedBox(width: _screenWidth*0.03,),
          DropdownButton(
            value: _dropdownGender,
            elevation: 16,
            onChanged: (value){
              setState(() {
                _dropdownGender = value;
                PatientForm.patient.gender = _dropdownGender;
              });
            },
            items: ['No especificado', 'Masculino', 'Femenino'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  _buildEPSField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: FaIcon(FontAwesomeIcons.solidIdCard),
            labelText: 'EPS*',
            hintText: 'Ingrese el nombre de la EPS aqui',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => _validateEPS(value),
          onChanged: (value) {
            PatientForm.patient.eps = value;
          }
//          onSaved: (value) => doctorSurname = value
      ),
    );
  }

  _buildStratumField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.venusMars),
          SizedBox(width: _screenWidth*0.03,),
          Text('Estrato'),
          SizedBox(width: _screenWidth*0.03,),
          DropdownButton(
            value: _dropdownStratum,
            elevation: 16,
            onChanged: (value){
              setState(() {
                _dropdownStratum = value;
                PatientForm.patient.stratum = int.parse(_dropdownStratum);
              });
            },
            items: ['1', '2', '3', '4', '5', '6'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  _validateIdentification(String value) {
    if(value.isEmpty){
      return 'Por favor, digite la Identificacion';
    }else if(value.length < 8){
      return 'Digite un numero de identificacion valido';
    }
  }

  _validateName(String value) {
    if(value.isEmpty){
      return 'Por favor, digite el nombre';
    }
  }

  _validateAge(String value) {
    if(value.isEmpty){
      return 'Por favor, digite la edad';
    }else if(value.length < 2 || value.length > 2){
      return 'por favor, digite una edad valida';
    }
  }

  _validateSurname(String value) {
    if(value.isEmpty){
      return 'Por favor, digite el apellido';
    }
  }

  _validateEPS(String value) {
    if(value.isEmpty){
      return 'Por favor, digite la experiencia';
    }
  }
}