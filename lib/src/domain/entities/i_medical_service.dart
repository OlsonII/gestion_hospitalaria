
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';

abstract class IMedicalService{

  Patient patient;
  DateTime date;
  String time;
  int turn;
  String state;
  double cost;

}