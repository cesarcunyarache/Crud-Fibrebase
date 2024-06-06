import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployee(Map<String, dynamic> employee) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .add(employee)
        // ignore: avoid_print
        .then((value) => print("Employee Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<Stream<QuerySnapshot>> getEmployee() async {
    return FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  Future updateEmployee(Map<String, dynamic> employee, String id) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .doc(id)
        .update(employee)
        // ignore: avoid_print
        .then((value) => print("Employye Updated"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future deleteEmployee(String id) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .doc(id)
        .delete()
        // ignore: avoid_print
        .then((value) => print("Employee Deleted"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }
}
