import 'package:flutter/material.dart';
import 'package:ieee/Screens/user_screen.dart';
import 'package:ieee/Widgets/info_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedSchoolYear = "2015";
  String selectedCollege = "IT대학";
  String selectedMajor = "컴퓨터학부";

  final recommendUrl = Uri.parse('http://10.0.2.2:5000/recommend');
  final monthlyUrl = Uri.parse('http://10.0.2.2:5000/monthly');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  @override
  void dispose() {
    _collegeController.dispose();
    _majorController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 8.0,
        title: const Text(
          "회원 정보 입력",
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "상위 소속을 입력하세요";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            selectedCollege = val!;
                          });
                        },
                        controller: _collegeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ex) IT 대학',
                          labelText: '상위 소속',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                      TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "소속을 입력하세요";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            selectedMajor = val!;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ex) 컴퓨터학부',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelText: '소속',
                        ),
                        controller: _majorController,
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                      TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "입학년도를 입력하세요";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            selectedSchoolYear = val!;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ex) 2015',
                          labelText: '입학년도',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        controller: _yearController,
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                    ],
                  ),
                ),
                OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        InfoList().userInfo["college"] = selectedCollege;
                        InfoList().userInfo["major"] = selectedMajor;
                        InfoList().userInfo["year"] = selectedSchoolYear;

                        await http
                            .post(recommendUrl,
                                body: json.encode({
                                  'college': selectedCollege,
                                  'year': selectedSchoolYear,
                                  'major': selectedMajor,
                                }))
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserScreen(
                                          year: selectedSchoolYear,
                                          major: selectedMajor,
                                          college: selectedCollege,
                                        ))));
                      }
                    },
                    child: const Text(
                      '로그인',
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
