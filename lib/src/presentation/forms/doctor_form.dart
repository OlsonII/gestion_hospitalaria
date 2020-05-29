import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';
import 'package:gestion_hospitalaria/src/infrastructure/repositories/doctor_repository.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';

class DoctorForm extends StatefulWidget {

  static GlobalKey<FormState> formDoctorKey = new GlobalKey<FormState>();

  static final doctor = new Doctor();
  static String response;

  bool submitForm(BuildContext context){
    if(DoctorForm.formDoctorKey.currentState.validate()){
      DoctorForm.formDoctorKey.currentState.save();
      _DoctorFormState().registerInfoDialog(context);
    }
  }

  @override
  _DoctorFormState createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;
  String _dropdownGender = 'No especificado';
  String _dropdownDegree = 'Medico';
  String _response = '';

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
        key: DoctorForm.formDoctorKey,
        autovalidate: false,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('Registrar Doctor', style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold),),
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
                _buildDegreeField(context),
                SizedBox(height: _screenHeight*0.02),
                _buildExperienceField(context),
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
            title: Text('Registro de doctor', style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Esta seguro de registrar a este doctor?'),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Registrar'),
                onPressed: (){
                  doctorBloc.sendDoctorEvent.add(CreateDoctor(doctor: DoctorForm.doctor));
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
    doctorBloc.doctorStream.forEach((element) {
      if(element is DoctorsRegistered){
        if(element.response == 'Doctor registrado satisfactoriamente'){
          DoctorForm.formDoctorKey.currentState.reset();
        }
        _registeredDoctorDialog(HomePage.scaffoldKey.currentContext, element.response);
      }
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
            DoctorForm.doctor.id = value;
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
            DoctorForm.doctor.name = value;
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
            DoctorForm.doctor.surname = value;
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
            DoctorForm.doctor.age = int.parse(value);
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
                DoctorForm.doctor.gender = _dropdownGender;
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

  _buildDegreeField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.userGraduate),
          SizedBox(width: _screenWidth*0.03,),
          Text('Titulo'),
          SizedBox(width: _screenWidth*0.03,),
          DropdownButton(
            value: _dropdownDegree,
            elevation: 16,
            onChanged: (value){
              setState(() {
                _dropdownDegree = value;
                DoctorForm.doctor.degree = _dropdownDegree;
              });
            },
            items: ['Medico', 'Pediatra', 'Oftalmologo', 'Odontologo'].map<DropdownMenuItem<String>>((String value) {
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

  _buildExperienceField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
          cursorColor: Colors.blueGrey,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Color.fromRGBO(78, 76, 173, 1),
            icon: FaIcon(FontAwesomeIcons.briefcase),
            labelText: 'Experiencia*',
            hintText: 'Ingrese la experiencia en meses aqui',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => _validateExperience(value),
          onChanged: (value) {
            DoctorForm.doctor.experience = int.parse(value);
          }
//          onSaved: (value) => doctorExperience = int.parse(value)
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

  _validateExperience(String value) {
    if(value.isEmpty){
      return 'Por favor, digite la experiencia';
    }
  }
}
