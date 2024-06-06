import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/data/database.dart';
import 'package:flutter_crud_firebase/presentation/widgets/text_form_field.dart';

// ignore: must_be_immutable
class EmployeeScreen extends StatefulWidget {
  DocumentSnapshot? ds;
  EmployeeScreen({super.key, this.ds});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final _keyForm = GlobalKey<FormState>();

  late TextEditingController textEditingControllerFirstName =
      TextEditingController();

  late TextEditingController textEditingControllerLastName =
      TextEditingController();

  late TextEditingController textEditingControllerAge = TextEditingController();

  late TextEditingController textEditingControllerPhone =
      TextEditingController();

  late TextEditingController textEditingControllerLocation =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    textEditingControllerFirstName =
        TextEditingController(text: widget.ds?['firtsName']);
    textEditingControllerLastName =
        TextEditingController(text: widget.ds?['lastName']);
    textEditingControllerAge = TextEditingController(text: widget.ds?['age']);
    textEditingControllerPhone =
        TextEditingController(text: widget.ds?['phone']);
    textEditingControllerLocation =
        TextEditingController(text: widget.ds?['location']);
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = widget.ds != null;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isUpdate ? 'Update ' : 'New ',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Employee',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              TextFormFieldCustom(
                label: 'First Name',
                controller: textEditingControllerFirstName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Esta campo es requerido";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldCustom(
                label: 'Last Name',
                controller: textEditingControllerLastName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Esta campo es requerido";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldCustom(
                label: 'Age',
                controller: textEditingControllerAge,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Esta campo es requerido";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldCustom(
                label: 'Phone',
                controller: textEditingControllerPhone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Esta campo es requerido";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldCustom(
                label: 'Location',
                controller: textEditingControllerLocation,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Esta campo es requerido";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    Map<String, dynamic> employee = {
                      "firtsName": textEditingControllerFirstName.text,
                      "lastName": textEditingControllerLastName.text,
                      "age": textEditingControllerAge.text,
                      "phone": textEditingControllerPhone.text,
                      "location": textEditingControllerLocation.text
                    };

                    if (isUpdate) {
                      DatabaseMethods().updateEmployee(employee, widget.ds!.id);
                    } else {
                      DatabaseMethods().addEmployee(employee);
                    }
                  }
                },
                child: Text(isUpdate ? 'Update' : 'Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
