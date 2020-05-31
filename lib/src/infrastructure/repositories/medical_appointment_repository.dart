import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:http/http.dart' as http;

class MedicalAppointmentRepository {

  static const String _URL = 'http://192.168.0.28:5000/medicalservice/medicalappointment';

  Future<List<MedicalAppointment>> searchAllMedicalAppointments() async {
    try{
      var response = await http.get(_URL);
      var decodedData = jsonDecode(response.body)["medicalAppointment"];
      final List<MedicalAppointment> medicalAppointments = new List();

      if(decodedData == null) return [];

      decodedData.forEach((medicalAppointment){
        var medicalAppointmentTemporal = MedicalAppointment.fromJson(medicalAppointment);
        medicalAppointments.add(medicalAppointmentTemporal);
      });

      return medicalAppointments;
    }catch(e){
      print(e);
    }
  }

  Future<MedicalAppointment> getSpecifyMedicalAppointment(String id, bool isPatient) async {
    try{
      var response = isPatient ?
        await http.get(_URL+'/patient/$id') :
        await http.get(_URL+'/doctor/$id');
      var decodedData = jsonDecode(response.body);
      return MedicalAppointment.fromJson(decodedData[0]);
    }catch(e){
      print(e);
    }
  }

  Future<String> createMedicalAppointment(MedicalAppointment medicalAppointment) async{
    return await http.post(_URL,
        headers: {'content-type': 'application/json'},
        body: medicalAppointmentToJson(medicalAppointment))
        .then((response) {
          print(jsonDecode(response.body)['mensaje']);
          return jsonDecode(response.body)['mensaje'];
        }).catchError((onError) {
      print('error: $onError');
    });
  }

}