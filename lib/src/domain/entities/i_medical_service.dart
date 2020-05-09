
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';

abstract class IMedicalService{

  Patient patient;
  DateTime date;
  DateTime hour;
  String state;
  double cost;

}