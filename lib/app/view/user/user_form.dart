// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, deprecated_member_use, camel_case_types, unused_import, missing_required_param, import_of_legacy_library_into_null_safe, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tcc/app/domain/services/auth_service.dart';
import 'package:tcc/app/view/bar/sidebar/sidebar.dart';
import 'package:tcc/app/view/home/home_screen.dart';
import 'package:tcc/app/view/sidebar/sidebar/sidebar_layout.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late String firstName;
  late String secondName;

  void onGoBack(dynamic value) {
    setState(() {});
  }

  Widget fieldfirstName() {
    return TextFormField(
        onChanged: (value) => firstName = value,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          hintText: 'Primeiro Nome',
        ));
  }

  Widget fieldsecondName() {
    return TextFormField(
        onChanged: (value) => secondName = value,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          hintText: 'Segundo Nome',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Cadastro de nome',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            fieldfirstName(),
            SizedBox(height: 25),
            fieldsecondName(),
            SizedBox(height: 25),
            FlatButton(
                color: Colors.green,
                onPressed: () {
                  var collection =
                      FirebaseFirestore.instance.collection('users');

                  collection
                      .doc(AuthService.getUser().uid)
                      .update({'firstName': firstName}).catchError(
                          (error) => print('Failed: $error'));
                  collection
                      .doc(AuthService.getUser().uid)
                      .update({'secondName': secondName}).catchError(
                          (error) => print('Failed: $error'));

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SideBarLayout()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Confirmar modificação',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
          ],
        ),
      ),
    );
  }
}
