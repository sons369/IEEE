import 'package:flutter/material.dart';
import 'package:ieee/info_list.dart';
import 'package:ieee/monthly_trend_book_list.dart';
import 'package:ieee/recommend_book_list_screen.dart';
import 'package:ieee/weekly_trend_book_list_screen.dart';
import 'package:ieee/yearly_trend_book_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.year,
    required this.college,
    required this.major,
  }) : super(key: key);
  final String year;
  final String college;
  final String major;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, String> recommendBookList = InfoList().recommendBookList;
  Map<String, String> trendBookList = InfoList().trendBookList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                              "Main Screen",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.amber,
                          )),
                    ],
                  ),
                  Container(
                    height: 40,
                  ),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.college,
                                style: const TextStyle(
                                  fontSize: 16,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.major,
                                style: const TextStyle(
                                  fontSize: 16,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.year,
                                style: const TextStyle(
                                  fontSize: 16,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.recommend_outlined,
                                color: Colors.amber,
                              ),
                              label: const Text(
                                "추천 도서 목록",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecommendBookListScreen(
                                                year: widget.year,
                                                college: widget.college,
                                                major: widget.major)));
                              },
                            ),
                            Container(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: recommendBookList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key =
                                        recommendBookList.keys.elementAt(index);
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: ListTile(
                                            title: Text(
                                              key,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              "${recommendBookList[key]}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.trending_up,
                                color: Colors.amber,
                              ),
                              label: const Text(
                                "주간 인기 도서",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WeeklyTrendBookListScreen(
                                                year: widget.year,
                                                college: widget.college,
                                                major: widget.major)));
                              },
                            ),
                            Container(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key =
                                        recommendBookList.keys.elementAt(index);
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            key,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "${recommendBookList[key]}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Container(
                              height: 40,
                            ),
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.trending_up,
                                color: Colors.amber,
                              ),
                              label: const Text(
                                "월간 인기 도서",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MonthlyTrendBookListScreen(
                                                year: widget.year,
                                                college: widget.college,
                                                major: widget.major)));
                              },
                            ),
                            Container(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key =
                                        recommendBookList.keys.elementAt(index);
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            key,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "${recommendBookList[key]}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Container(
                              height: 40,
                            ),
                            OutlinedButton.icon(
                              icon: const Icon(
                                Icons.trending_up,
                                color: Colors.amber,
                              ),
                              label: const Text(
                                "연간 인기 도서",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            YearlyTrendBookListScreen(
                                                year: widget.year,
                                                college: widget.college,
                                                major: widget.major)));
                              },
                            ),
                            Container(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key =
                                        recommendBookList.keys.elementAt(index);
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            key,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "${recommendBookList[key]}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
