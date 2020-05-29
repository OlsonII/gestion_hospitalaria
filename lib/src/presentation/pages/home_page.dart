import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/dashboard_page.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/doctors_page.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/medical_appointments_page.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/medical_exams_page.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/patients_page.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();

  static GlobalKey scaffoldKey = new GlobalKey();

}

class _HomePageState extends State<HomePage> {

  Size _screenSize;
  double _screenWidth;
  double _screenHeight;
  int _selectedPage = 0;
  final _standarRadius = Radius.circular(20.0);
  String _title = 'Tablero';
  Color _textColor = Color.fromRGBO(27, 26, 41, 1);
  Color _iconColor = Color.fromRGBO(55, 104, 242, 0.5);
  Color _unSelectedTextColor = Color.fromRGBO(193, 192, 198, 1);

  List<Widget> _pages = [
    DashboardPage(),
    MedicalAppointmentsPage(),
    MedicalExamsPage(),
    DoctorsPage(),
    PatientsPage()
  ];

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;

    return Scaffold(
        key: HomePage.scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: double.infinity,
                color: Color.fromRGBO(201, 207, 223, 1)
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              child: Row(
                children: <Widget>[
                  _buildMenu(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: _standarRadius,
                              bottomRight: _standarRadius
                          ),
                          color: Color.fromRGBO(246, 245, 253, 1)
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                                  child: Text(_title, style: TextStyle(fontSize: 22.0))),
                              Expanded(child: Container()),
                            ],
                          ),
                          Expanded(
                            child: _pages[_selectedPage],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _buildMenu() {
    return _screenWidth < 700 ?
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: _standarRadius, bottomLeft: _standarRadius),
        color: Colors.white,
      ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.chartLine, color: _selectedPage == 0 ? _iconColor : _unSelectedTextColor),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    _selectedPage = 0;
                    _title = 'Tablero';
                  });
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.notesMedical, color: _selectedPage == 1 ? _iconColor : _unSelectedTextColor),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    _selectedPage = 1;
                    _title = 'Citas Medicas';
                  });
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.syringe, color: _selectedPage == 2 ? _iconColor : _unSelectedTextColor),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    _selectedPage = 2;
                    _title = 'Examenes';
                  });
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.userMd, color: _selectedPage == 3 ? _iconColor : _unSelectedTextColor),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    _selectedPage = 3;
                    _title = 'Doctores';
                  });
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.userAlt, color: _selectedPage == 4 ? _iconColor : _unSelectedTextColor),
                  ],
                ),
                onPressed: (){
                  setState(() {
                    _selectedPage = 4;
                    _title = 'Pacientes';
                  });
                },
              )
            ],
          ),
        ) :
    Container(
      width: _screenWidth < 1100
          ? _screenWidth*0.3 : _screenWidth*0.18,
      padding: EdgeInsets.only(left: 30.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: _standarRadius, bottomLeft: _standarRadius),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: _screenHeight*0.3,
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.chartLine, color: _selectedPage == 0 ? _iconColor : _unSelectedTextColor),
                Expanded(child: Container()),
                Text('Tablero', style: TextStyle(fontSize: 17.0, color: _selectedPage == 0 ? _textColor : _unSelectedTextColor)),
                Expanded(child: Container()),
              ],
            ),
            onPressed: (){
              setState(() {
                _selectedPage = 0;
                _title = 'Tablero';
              });
            },
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.notesMedical, color: _selectedPage == 1 ? _iconColor : _unSelectedTextColor),
                Expanded(child: Container()),
                Text('Citas medicas', style: TextStyle(fontSize: 17.0, color: _selectedPage == 1 ? _textColor : _unSelectedTextColor)),
                Expanded(child: Container()),
              ],
            ),
            onPressed: (){
              setState(() {
                _selectedPage = 1;
                _title = 'Citas Medicas';
              });
            },
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.syringe, color: _selectedPage == 2 ? _iconColor : _unSelectedTextColor),
                Expanded(child: Container()),
                Text('Examenes', style: TextStyle(fontSize: 17.0, color: _selectedPage == 2 ? _textColor : _unSelectedTextColor)),
                Expanded(child: Container()),
              ],
            ),
            onPressed: (){
              setState(() {
                _selectedPage = 2;
                _title = 'Examenes';
              });
            },
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.userMd, color: _selectedPage == 3 ? _iconColor : _unSelectedTextColor),
                Expanded(child: Container()),
                Text('Doctores', style: TextStyle(fontSize: 17.0, color: _selectedPage == 3 ? _textColor : _unSelectedTextColor)),
                Expanded(child: Container()),
              ],
            ),
            onPressed: (){
              setState(() {
                _selectedPage = 3;
                _title = 'Doctores';
              });
            },
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.userAlt, color: _selectedPage == 4 ? _iconColor : _unSelectedTextColor),
                Expanded(child: Container()),
                Text('Pacientes', style: TextStyle(fontSize: 17.0, color: _selectedPage == 4 ? _textColor : _unSelectedTextColor)),
                Expanded(child: Container()
                ),
              ],
            ),
            onPressed: (){
              setState(() {
                _selectedPage = 4;
                _title = 'Pacientes';
              });
            },
          )
        ],
      ),
    );
  }
}
