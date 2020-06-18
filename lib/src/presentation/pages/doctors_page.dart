import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_bloc.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_event.dart';
import 'package:gestion_hospitalaria/src/application/bloc/doctor/doctor_state.dart';
import 'package:gestion_hospitalaria/src/presentation/forms/doctor_form.dart';
import 'package:gestion_hospitalaria/src/presentation/loaders/color_progress_indicator.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/doctor_profile_page.dart';

class DoctorsPage extends StatefulWidget {

  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _screenLow;

  final _standarRadius = Radius.circular(13.0);

  Widget _pageSelected;

  @override
  Widget build(BuildContext context) {

    if(_pageSelected == null) _pageSelected = _buildDoctorsContainer();

    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;
    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

    doctorBloc.sendDoctorEvent.add(SearchAllDoctors());

    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _pageSelected //_register ? DoctorForm() : _buildDoctorsContainer(),
          ),
          _buildButtons()
        ],
      ),
    );

  }

  _buildButtons() {
    if(_pageSelected is DoctorForm){
      return _buildCompleteButton();
    }else if(_pageSelected is DoctorProfilePage){
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
          child: Text(_screenLow ? 'Registrar' : 'Registrar doctor', style: TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: (){
            setState(() {
              _pageSelected = DoctorForm();
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
            child: Text(_screenLow ? 'Modificar' :'Modificar doctor', style: TextStyle(fontSize: 17.0, color: Colors.white),),
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
              _pageSelected = _buildDoctorsContainer();
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
                DoctorForm().submitForm(context);
                _pageSelected = _buildDoctorsContainer();
                doctorBloc.sendDoctorEvent.add(SearchAllDoctors());
              });
            },
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Container _buildDoctorsContainer() {
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
          stream: doctorBloc.doctorStream,
          initialData: [],
          builder: (context, snapshot){
            if(snapshot.data is DoctorsLoaded){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.doctors.length,
                  itemBuilder: (context, item) => _createItemList(context, snapshot.data.doctors[item])
              );
            }
            else{
              return Center(child: ColorProgressIndicator(color1: Color.fromRGBO(251, 139, 142, 1), color2: Color.fromRGBO(55, 104, 242, 0.5), color3: Color.fromRGBO(78, 76, 173, 1),));
            }
          },
        )
    );
  }

  _createItemList(BuildContext context, doctor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text(doctor.name),
        subtitle: Text('${doctor.degree} - ${doctor.workday}'),
        onTap: (){
          setState(() {
            _pageSelected = DoctorProfilePage(doctor);
          });
        },
      ),
    );
  }

  _buildComplete() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(_standarRadius),
            color: Color.fromRGBO(78, 76, 173, 1)
        ),
        child: FlatButton(
          child: Text(_screenLow ? 'Completar' : 'Completar registro',
              style: TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: (){
            setState(() {
//              _register = !_register;
              DoctorForm().submitForm(context);
            });
          },
        ),
      ),
    );
  }
}
