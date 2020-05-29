import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';

class PatientRepository{

  static const String _URL = 'http://192.168.0.28:5000/medicalService/Patient';

  Future<List<Patient>> getAllPatients() async {
    try{
      var response = await http.get(_URL);
      var decodedData = jsonDecode(response.body)["patients"];
      final List<Patient> patients = new List();

      if(decodedData == null) return [];

      decodedData.forEach((patient){
        var patientTemporal = Patient.fromJson(patient);
        patients.add(patientTemporal);
      });

      return patients;
    }catch(e){
      print(e);
    }
  }

  Future<Patient> getSpecifyPatient(String id) async {
    try{
      var response = await http.get(_URL+'/$id');
      var decodedData = jsonDecode(response.body);
      return Patient.fromJson(decodedData[0]);
    }catch(e){
      print(e);
    }
  }

  Future<String> createPatient(Patient patient) async{
    var pat = patientToJson(patient);
    print(pat);
    return await http.post(_URL, headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
        body: patientToJson(patient)
    ).then((response) {
      var res = jsonDecode(response.body)['mensaje'];
      print('response repository: $res');
      return res;
    }).catchError((onError) {
      print('error: $onError');
    });
  }

}