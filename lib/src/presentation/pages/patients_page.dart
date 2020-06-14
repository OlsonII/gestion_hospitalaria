import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/patient/patient_state.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';
import 'package:gestion_hospitalaria/src/presentation/forms/patient_form.dart';
import 'package:gestion_hospitalaria/src/presentation/loaders/color_progress_indicator.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/patient_profile_page.dart';

class PatientsPage extends StatefulWidget {

  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;
  Widget _pageSelected;

  final _standarRadius = Radius.circular(13.0);


  @override
  Widget build(BuildContext context) {

    if(_pageSelected == null) _pageSelected = _buildPatientsContainer();
    patientBloc.sendPatientEvent.add(SearchAllPatients());

    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;
    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _pageSelected
          ),
          _buildButtons()
        ],
      ),
    );
  }
  _buildButtons() {
    if(_pageSelected is PatientForm){
      return _buildCompleteButton();
    }else if(_pageSelected is PatientProfilePage){
      return _buildModifyButton();
    }else{
      return _buildRegisterButton();
    }
  }

  Center _buildRegisterButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(_standarRadius),
            color: Color.fromRGBO(78, 76, 173, 1)
        ),
        child: FlatButton(
          child: Text(_screenLow ? 'Registrar' : 'Registrar paciente', style: TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: (){
            setState(() {
               _pageSelected = PatientForm();
               patientBloc.sendPatientEvent.add(SearchAllPatients());
            });
          },
        ),
      ),
    );
  }

  Widget _buildModifyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: _screenWidth*0.05),
        _buildBackButton(),
        Expanded(child: Container()),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(_standarRadius),
              color: Color.fromRGBO(251, 139, 142, 1)
          ),
          child: FlatButton(
            child: Text(_screenLow ? 'Modificar' :'Modificar paciente', style: TextStyle(fontSize: 17.0, color: Colors.white),),
            onPressed: (){},
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Container _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_standarRadius),
          color: Color.fromRGBO(78, 76, 173, 1)
      ),
      child: FlatButton(
        child: Text('Atras', style: TextStyle(fontSize: 17.0, color: Colors.white),),
        onPressed: (){
          setState(() {
            _pageSelected = _buildPatientsContainer();
          });
        },
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: _screenWidth*0.05),
        _buildBackButton(),
        Expanded(child: Container()),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(_standarRadius),
              color: Color.fromRGBO(251, 139, 142, 1)
          ),
          child: FlatButton(
            child: Text(_screenLow ? 'Completar' : 'Completar registro',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: (){
              setState(() {
                PatientForm().submitForm(context);
                _pageSelected = _buildPatientsContainer();
              });
            },
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Container _buildPatientsContainer() {
    return Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(_standarRadius),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: StreamBuilder(
          stream: patientBloc.patientStream,
          initialData: [],
          builder: (context, snapshot){
            if(snapshot.data is PatientsLoaded){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.patients.length,
                  itemBuilder: (context, item) => _createItemList(context, snapshot.data.patients[item])
              );
            }
            else{
              return Center(child: ColorProgressIndicator(color1: Color.fromRGBO(251, 139, 142, 1), color2: Color.fromRGBO(55, 104, 242, 0.5), color3: Color.fromRGBO(78, 76, 173, 1),));
            }
          },
        )
    );
  }

  _createItemList(BuildContext context, Patient patient) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text('${patient.name} ${patient.surname}'),
        subtitle: Text('Estrato: ${patient.stratum} - ${patient.eps}'),
        onTap: (){
          setState(() {
            _pageSelected = PatientProfilePage(patient);
          });
        },
      ),
    );
  }
}
