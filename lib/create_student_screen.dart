// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/models/student_model.dart';
import 'package:flutter/material.dart';

class CreateStudentScreen extends StatefulWidget {
  const CreateStudentScreen({super.key});

  @override
  State<CreateStudentScreen> createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController image = TextEditingController();

  final _key = GlobalKey<FormState>();

  crateStudent(String name, String semester, String image) async {
    final db = FirebaseFirestore.instance;
    final studentRef = db.collection('students').doc();
    Student student = Student(name: name, semester: semester, image: image);
    await studentRef.set(student.toJson()).then((value) {
      var snackBar = const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Student created successfully!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
      log("Student created successfully!");
    }, onError: (e) {
      var snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      log("Error : $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Student"),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: semester,
                decoration: const InputDecoration(hintText: "Semester"),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: image,
                decoration: const InputDecoration(hintText: "image"),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  log('Name: ${name.text} \nSemester:  ${semester.text}');
                  if (name.text.isNotEmpty && semester.text.isNotEmpty) {
                    await crateStudent(name.text, semester.text, image.text);
                  } else {
                    var snackBar = const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please Enter name and Semester!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("Add Student"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
