import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/presentation/forms/patient_form.dart';
import 'package:gestion_hospitalaria/src/presentation/loaders/color_progress_indicator.dart';

class PatientsPage extends StatefulWidget {

  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Size _screenSize;

  double _screenWidth;

  double _screenHeight;

  bool _screenLow;

  final _standarRadius = Radius.circular(13.0);

  bool _register = false;

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    _screenWidth < 700 ? _screenLow = true : _screenLow = false;

    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _register ? PatientForm() : _buildPatientsContainer(),
          ),
          !_register ? _buildButtons() : _buildComplete()
        ],
      ),
    );

  }

  Row _buildButtons() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(_standarRadius),
                  color: Color.fromRGBO(78, 76, 173, 1)
              ),
              child: FlatButton(
                child: Text(_screenLow ? 'Registrar' : 'Registrar paciente', style: TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: (){
                  setState(() {
                    _register = !_register;
                  });
                },
              ),
            ),
            SizedBox(
              width: _screenWidth*0.05,
            ),
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
              child: Center(child: ColorProgressIndicator(color1: Color.fromRGBO(251, 139, 142, 1), color2: Color.fromRGBO(55, 104, 242, 0.5), color3: Color.fromRGBO(78, 76, 173, 1),))
              /*child: StreamBuilder(
                stream: doctorBloc.doctorStream,
                initialData: [],
                builder: (context, snapshot){
                  if(snapshot.data is DoctorsLoaded){
                    return ListView.builder(
                        itemCount: snapshot.data.doctors.length,
                        itemBuilder: (context, item) => _createItemList(context, snapshot.data.doctors[item])
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )*/
          );
  }

  _createItemList(BuildContext context, doctor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text(doctor.name),
        subtitle: Text('${doctor.degree} - ${doctor.workday}'),
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
              _register = !_register;
            });
          },
        ),
      ),
    );
  }
}
