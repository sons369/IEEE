import 'package:flutter/material.dart';
import 'package:ieee/Widgets/info_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.recommendBookList,
  }) : super(key: key);
  final List<dynamic> recommendBookList;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _years = [
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
  ];
  final List<String> _months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ];
  String _selectedYear = "2018";
  String _selectedMonth = "01";
  int _selectedIndex = 0;

  final recommendUrl = Uri.parse('http://10.0.2.2:5000/recommend');
  final monthlyUrl = Uri.parse('http://10.0.2.2:5000/monthly');
  final yearlyUrl = Uri.parse('http://10.0.2.2:5000/yearly');

  late dynamic year;
  late dynamic college;
  late dynamic major;
  late List<dynamic> recommendList = widget.recommendBookList;
  late List<dynamic> monthlyList;

  @override
  void initState() {
    super.initState();
    if (InfoList().userInfo.isNotEmpty) {
      year = InfoList().userInfo["year"];
      college = InfoList().userInfo["college"];
      major = InfoList().userInfo["major"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 8.0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.edit))
        ],
        title: const Text(
          "회원 정보",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: const Icon(Icons.person),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.cyan,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: "추천 도서"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "월간 도서"),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: "연간 도서"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "상위 소속",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                college,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "소속",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                major,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "입학년도",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                year,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                  ),
                  IndexedStack(
                    index: _selectedIndex,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.recommend,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "추천 도서 목록",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: recommendList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Card(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              child: Text(
                                                recommendList[index]["서명"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              child: Text(
                                                recommendList[index]["저자명"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.eco,
                                                  color: Colors.yellow,
                                                  size: 16,
                                                ),
                                                Text(
                                                  "${index + 1}등",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  recommendList[index]["소장위치"],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            isThreeLine: true,
                                            // dense: true,
                                          ),
                                        ],
                                        mainAxisSize: MainAxisSize.min,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      elevation: 4,
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                      // 추천 도서 목록
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "월간 인기 도서",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    child: DropdownButton(
                                        icon: const Icon(Icons.arrow_downward),
                                        isDense: true,
                                        iconSize: 20,
                                        elevation: 16,
                                        value: _selectedYear,
                                        underline: Container(
                                          height: 2,
                                          color: Colors.cyan,
                                        ),
                                        isExpanded: true,
                                        items: _years.map((String y) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              y,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            value: y,
                                          );
                                        }).toList(),
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _selectedYear = value;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: DropdownButton(
                                        icon: const Icon(Icons.arrow_downward),
                                        isDense: true,
                                        iconSize: 20,
                                        elevation: 16,
                                        value: _selectedMonth,
                                        underline: Container(
                                          height: 2,
                                          color: Colors.cyan,
                                        ),
                                        isExpanded: true,
                                        items: _months.map((String m) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              m,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            value: m,
                                          );
                                        }).toList(),
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _selectedMonth = value;
                                          });
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        primary: Colors.cyan),
                                    icon: const Icon(
                                      Icons.search,
                                      size: 12,
                                    ),
                                    label: const Text(
                                      "검색",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                          ),
                          Container(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: recommendList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Card(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              child: Text(
                                                recommendList[index]["서명"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              child: Text(
                                                recommendList[index]["저자명"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.eco,
                                                  color: Colors.yellow,
                                                  size: 16,
                                                ),
                                                Text(
                                                  "${index + 1}등",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  recommendList[index]["소장위치"],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            isThreeLine: true,
                                            // dense: true,
                                          ),
                                        ],
                                        mainAxisSize: MainAxisSize.min,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      elevation: 4,
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "연간 인기 도서",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: DropdownButton(
                                        icon: const Icon(Icons.arrow_downward),
                                        isDense: true,
                                        iconSize: 20,
                                        elevation: 16,
                                        value: _selectedYear,
                                        underline: Container(
                                          height: 2,
                                          color: Colors.cyan,
                                        ),
                                        isExpanded: true,
                                        items: _years.map((String y) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              y,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            value: y,
                                          );
                                        }).toList(),
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _selectedYear = value;
                                          });
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        primary: Colors.cyan),
                                    icon: const Icon(
                                      Icons.search,
                                      size: 12,
                                    ),
                                    label: const Text(
                                      "검색",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: recommendList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Card(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              child: Text(
                                                recommendList[index]["서명"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              child: Text(
                                                recommendList[index]["저자명"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.eco,
                                                  color: Colors.yellow,
                                                  size: 16,
                                                ),
                                                Text(
                                                  "${index + 1}등",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  recommendList[index]["소장위치"],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            isThreeLine: true,
                                            // dense: true,
                                          ),
                                        ],
                                        mainAxisSize: MainAxisSize.min,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      elevation: 4,
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
