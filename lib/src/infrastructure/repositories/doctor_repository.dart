import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorRepository {
  static const String _URL = 'http://192.168.0.28:5000/medicalservice/doctor';

  Future<List<Doctor>> getAllDoctors() async {
    try{
      var response = await http.get(_URL);
      var decodedData = jsonDecode(response.body)["doctors"];
      final List<Doctor> doctors = new List();

      if(decodedData == null) return [];

      decodedData.forEach((doctor){
        var doctorTemporal = Doctor.fromJson(doctor);
        doctors.add(doctorTemporal);
      });

      return doctors;
    }catch(e){
      print(e);
    }
  }

  Future<Doctor> getSpecifyDoctor(String id) async {
    try{
      var response = await http.get(_URL+'/$id');
      var decodedData = jsonDecode(response.body);
      return Doctor.fromJson(decodedData[0]);
    }catch(e){
      print(e);
    }
  }

  Future<bool> createDoctor(Doctor doctor) async{
    return await http.post(_URL, headers: {'content-type': 'application/json'}, body: doctorToJson(doctor))
        .then((response) => true)
        .catchError((onError) => onError);
  }

}