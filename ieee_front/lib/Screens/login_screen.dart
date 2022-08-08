import 'package:flutter/material.dart';
import 'package:ieee/main_screen.dart';
import 'info_list.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> schoolYearList = InfoList().schoolYear;
  List<String> collegeList = InfoList().collegeList;
  List<String> majorList = InfoList().itMajorList;

  String selectedSchoolYear = "2015";
  String selectedCollege = "IT대학";
  String selectedMajor = "컴퓨터학부";

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.menu_book,
                        color: Colors.amber,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "IEEE Library App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                ),

                /*
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "상위 소속",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(10),
                                  isDense: true,
                                  value: selectedCollege,
                                  items: collegeList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCollege = value.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 16,
                                  underline: const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "소속",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(10),
                                  isDense: true,
                                  value: selectedMajor,
                                  items: majorList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMajor = value.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 16,
                                  underline: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "입학년도",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(10),
                                  isDense: true,
                                  value: selectedSchoolYear,
                                  items: schoolYearList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSchoolYear = value.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 16,
                                  underline: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                OutlinedButton.icon(
                    icon: const Icon(
                      Icons.save_rounded,
                      size: 24,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(
                                    year: selectedSchoolYear,
                                    college: selectedCollege,
                                    major: selectedMajor,
                                  )));
                    },
                    label: const Text(
                      '입력',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                */

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
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,),
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
                          hintText: 'ex) 컴퓨터학과',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,),
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
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,),
                        ),
                        controller: _yearController,
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                    icon: const Icon(
                      Icons.save_rounded,
                      size: 24,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  year: selectedSchoolYear,
                                  college: selectedCollege,
                                  major: selectedMajor,
                                )));
                      }
                    },
                    label: const Text(
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
