import 'package:flutter/material.dart';
import 'package:ieee/Screens/main_screen.dart';
import 'package:ieee/Widgets/info_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final recommendUrl = Uri.parse('http://10.0.2.2:5000/recommend');
  final monthlyUrl = Uri.parse('http://10.0.2.2:5000/monthly');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 8.0,
        title: const Text(
          "회원 정보",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: const Icon(Icons.menu_book),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        InfoList().userInfo["college"] = selectedCollege;
                        InfoList().userInfo["major"] = selectedMajor;
                        InfoList().userInfo["year"] = selectedSchoolYear;
                        final response = await http
                            .post(recommendUrl,
                            body: json.encode({
                              'college': selectedCollege,
                              'year': selectedSchoolYear,
                              'major': selectedMajor,
                            }))
                        //     .then((value) async => InfoList().tmpResponse =
                        // await http.get(recommendUrl))
                            .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen())));
                      }
                    },
                    child: const Text(
                      '입력',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
