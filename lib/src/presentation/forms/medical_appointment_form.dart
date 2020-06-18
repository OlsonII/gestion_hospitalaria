
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_state.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/medical_appointment/medical_appointment_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';
import 'package:gestion_hospitalaria/src/infrastructure/utils/global_date.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';
import 'package:gestion_hospitalaria/src/presentation/utils/datetime_picker.dart';

class MedicalAppointmentForm extends StatefulWidget {

  static GlobalKey<FormState> formMedicalAppointmentKey = new GlobalKey<FormState>();

  static String response;

  bool submitForm(BuildContext context){
    if(MedicalAppointmentForm.formMedicalAppointmentKey.currentState.validate()){
      MedicalAppointmentForm.formMedicalAppointmentKey.currentState.save();
      _MedicalAppointmentFormState().registerInfoDialog(context);
    }
  }

  @override
  _MedicalAppointmentFormState createState() => _MedicalAppointmentFormState();
}

class _MedicalAppointmentFormState extends State<MedicalAppointmentForm> {

  static final medicalAppointment = new MedicalAppointment();
  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;
  String _dropdownType = 'Medicina General';
  String _degreeSelected = 'Doctor';

  List<String> added = [];
  List<Doctor> doctorsByDegree = [];

  final _standartRadius = Radius.circular(13.0);
  String _selectedDoctor;

  GlobalKey _dropDownDoctorKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

    doctorBloc.sendDoctorEvent.add(SearchAllDoctors());

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
    return StreamBuilder(
      stream: doctorBloc.doctorStream,
      initialData: [],
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data is DoctorsLoaded){
          if(snapshot.data.doctors != null ){
            doctorsByDegree = snapshot.data.doctors;
            return Container(
              width: _screenWidth*0.50,
              child: Form(
                key: MedicalAppointmentForm.formMedicalAppointmentKey,
                autovalidate: false,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('Registrar Cita Medica', style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height: _screenHeight*0.02),
                        _buildTypeOfMedicalAppointment(context),
                        SizedBox(height: _screenHeight*0.02),
                        _buildDoctorField(context),
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
        }
        else{
          return Container();
        }
      },
    );

  }

  _filterDoctors(){
    var doctorsSeleteds = [];
    doctorsByDegree.forEach((doctor){
      if(doctor.degree == _degreeSelected){
        doctorsSeleteds.add(doctor);
      }
    });
    return doctorsSeleteds;
  }

  registerInfoDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Registro de cita medica', style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Esta seguro de registrar esta cita medica?'),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Registrar'),
                onPressed: (){
                  medicalAppointment.date = globalDate.dateSelected;
                  if(_validateDate(medicalAppointment.date)){
                    medicalAppointmentBloc.sendMedicalAppointmentEvent.add(RegisterMedicalAppointmentEvent(medicalAppointment: medicalAppointment));
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
    medicalAppointmentBloc.medicalAppointmentStream.forEach((element) {
      if(element is MedicalAppointmentRegistered){
        if(element.response == 'Cita medica creada satisfactoriamente'){
          MedicalAppointmentForm.formMedicalAppointmentKey.currentState.reset();
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

  _buildTypeOfMedicalAppointment(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.notesMedical, color: Color.fromRGBO(140, 140, 140, 1)),
          SizedBox(width: _screenWidth*0.03,),
          Text('Cita de', style: TextStyle(fontSize: 17.0, color: Color.fromRGBO(140, 140, 140, 1)),),
          SizedBox(width: _screenWidth*0.03,),
          DropdownButton(
            value: _dropdownType,
            elevation: 16,
            onChanged: (value){
              setState(() {
                _dropdownType = value;
                _selectedDoctor = null;
                switch(_dropdownType){
                  case 'Medicina General':
                    _degreeSelected = 'Doctor';
                    break;
                  case 'Pediatria':
                    _degreeSelected = 'Pediatra';
                    break;
                  case 'Oftalmologia':
                    _degreeSelected = 'Oftalmologo';
                    break;
                  case 'Odontologia':
                    _degreeSelected = 'Odontologo';
                    break;
                }
              });
            },
            items: ['Medicina General', 'Pediatria', 'Oftalmologia', 'Odontologia'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 17.0, color: Color.fromRGBO(140, 140, 140, 1)),),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  _buildDoctorField(BuildContext context) {
    try{
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(FontAwesomeIcons.notesMedical, color: Color.fromRGBO(140, 140, 140, 1)),
              SizedBox(width: _screenWidth*0.03,),
              Text('Medico', style: TextStyle(fontSize: 17.0, color: Color.fromRGBO(140, 140, 140, 1)),),
              SizedBox(width: _screenWidth*0.03,),
              _filterDoctors().length > 0 ? _buildDoctorsDropdown() : Text('No hay doctores registrados')
            ],
          )
      );
    }catch(e){
      print(e.toString());
    }
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
              medicalAppointment.patient = new Patient(identification: value);
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

  _buildDoctorsDropdown() {
    return DropdownButton(
      key: _dropDownDoctorKey,
      value: _selectedDoctor,
      elevation: 16,
      onChanged: (value){
        setState(() {
          _selectedDoctor = value;
          medicalAppointment.doctor = new Doctor(identification: value);
        });
      },
      items: _filterDoctors().map<DropdownMenuItem<String>>((dynamic value) {
        print('doctor selected: ${value.identification} - ${value.name}');
        return DropdownMenuItem<String>(
          value: '${value.identification}',
          child: Text('${value.name} ${value.surname}', style: TextStyle(fontSize: 17.0, color: Color.fromRGBO(140, 140, 140, 1)),),
        );
      }).toList(),
    );
  }
}