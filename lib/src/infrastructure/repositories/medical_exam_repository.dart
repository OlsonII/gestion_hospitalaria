import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/medical_appointment.dart';
import 'package:gestion_hospitalaria/src/domain/entities/medical_exam.dart';
import 'package:http/http.dart' as http;

class MedicalExamRepository {

  static const String _URL = 'http://192.168.0.28:5000/medicalservice/medicalexam';

  Future<List<MedicalExam>> searchAllMedicalExams() async {
    try{
      var response = await http.get(_URL);
      var decodedData = jsonDecode(response.body)["medicalExam"];
      final List<MedicalExam> medicalExams = new List();

      if(decodedData == null) return [];

      decodedData.forEach((medicalAppointment){
        var medicalAppointmentTemporal = MedicalExam.fromJson(medicalAppointment);
        medicalExams.add(medicalAppointmentTemporal);
      });

      return medicalExams;
    }catch(e){
      print(e);
    }
  }

  Future<List<MedicalExam>> getSpecifyMedicalExam(String id) async {
    try{
      var response = await http.get(_URL+'/$id');
      var decodedData = jsonDecode(response.body)["medicalExam"];
      final List<MedicalExam> medicalExams = new List();

      if(decodedData == null) return [];

      decodedData.forEach((medicalAppointment){
        var medicalExamTemporal = MedicalExam.fromJson(medicalAppointment);
        medicalExams.add(medicalExamTemporal);
      });

      return medicalExams;
    }catch(e){
      print(e);
    }
  }

  Future<String> createMedicalExam(MedicalExam medicalExam) async{
    return await http.post(_URL,
        headers: {'content-type': 'application/json'},
        body: medicalExamToJson(medicalExam))
        .then((response) {
      return jsonDecode(response.body)['mensaje'];
    }).catchError((onError) {
      print('error: $onError');
    });
  }

  Future<String> cancelMedicalExam(MedicalExam medicalExam) async {
    try{
      var response = await http.put(_URL+'/Cancel',
          headers: {'content-type': 'application/json'},
          body: medicalExamToJson(medicalExam));
      return jsonDecode(response.body)['mensaje'];

    }catch(e){
      print('error: ${e.toString()}');
      return 'Error';
    }
  }

  Future<String> completeMedicalExam(MedicalExam medicalExam) async {
    try{
      var response = await http.put(_URL+'/Complete',
          headers: {'content-type': 'application/json'},
          body: medicalExamToJson(medicalExam));
      return jsonDecode(response.body)['mensaje'];

    }catch(e){
      print('error: ${e.toString()}');
      return 'Error';
    }
  }
}