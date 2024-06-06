import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/data/database.dart';
import 'package:flutter_crud_firebase/presentation/screens/employee_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? employeeStream;

  getOnTheLoad() async {
    employeeStream = await DatabaseMethods().getEmployee();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allEmployees() {
    return StreamBuilder(
        stream: employeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];

                      return ListTile(
                        trailing: Container(
                          alignment: Alignment.center,
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmployeeScreen(
                                                  ds: ds,
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    DatabaseMethods().deleteEmployee(ds.id);
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red))
                            ],
                          ),
                        ),
                        leading: const Icon(Icons.person),
                        subtitle: Text(ds['lastName']),
                        title: Text(ds['firtsName']),
                      );
                    })
                : Container(
                    alignment: Alignment.center,
                    child: const Text('No found data'),
                  );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Flutter',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Firebase',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EmployeeScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    /*    color: Colors.white, */
                    borderRadius: BorderRadius.circular(10)),
                child: allEmployees(),
              )
            ],
          ),
        ));
  }
}
