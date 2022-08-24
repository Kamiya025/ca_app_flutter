import 'package:ca_app_flutter/src/constant/constant_bottom_navigation.dart';
import 'package:ca_app_flutter/src/home/home_viewmodel.dart';
import 'package:ca_app_flutter/src/home/linechart_view.dart';
import 'package:ca_app_flutter/src/home/piechart_view.dart';
import 'package:ca_app_flutter/src/home/radarchart_view.dart';
import 'package:ca_app_flutter/src/home/skeleton_home.dart';
import 'package:ca_app_flutter/src/model/all_tickets_status.dart';
import 'package:ca_app_flutter/src/model/status.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:text_scroll/text_scroll.dart';
import '../Tickets/Tickets_view.dart';
import '../model/data_type_request.dart';
import '../model/project.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CarouselController buttonCarouselController = CarouselController();
  HomeViewModel homeViewModel = HomeViewModel();
  final int _selectedIndex = 0;

  @override
  void dispose() {
    homeViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      homeViewModel = HomeViewModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bgimage.jpg"),
          opacity: 0.85,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          foregroundColor: Colors.black,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Image(
                  image: AssetImage("assets/fpt_logo.png"),
                  width: 75,
                ),
              ),
              Text("CA Ticket Management")
            ],
          ),
          titleSpacing: 30,
          // centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top:15, bottom: 15, right: 20, left: 20),

                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Dashboard",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Column(
                    children: [
                      //chart radar
                      StreamBuilder(
                          stream: homeViewModel.allTicketsStatusStream,
                          builder: (context,
                              AsyncSnapshot<AllTicketsStatus> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.circle,
                                          height: 200,
                                          width: 200),
                                    ),
                                  ),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return RadarChartView(
                                      dataTypeRequest:
                                          DataTypeRequest.fromRequests(
                                              snapshot.data!.status!),
                                      callBack: (i) {
                                        if (i >= 0) {
                                          buttonCarouselController
                                              .animateToPage(i);
                                        }
                                      });
                                }
                            }
                          }),

                      StreamBuilder(
                          stream: homeViewModel.allTicketsStatusStream,
                          builder: (context,
                              AsyncSnapshot<AllTicketsStatus> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return linesView();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Column(
                                    children: [

                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            CarouselSlider(
                                              carouselController:
                                                  buttonCarouselController,
                                              options: CarouselOptions(
                                                viewportFraction: 1,
                                                height: 160,
                                                disableCenter: false,
                                                pageSnapping: true,
                                              ),
                                              items: snapshot.data!.status!
                                                  .map((item) => carouselItem(item))
                                                  .toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            }
                          }),
                      //chart pie
                      StreamBuilder(
                          stream: homeViewModel.allTicketsStatusStream,
                          builder: (context,
                              AsyncSnapshot<AllTicketsStatus> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return skeletonChart();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return PieChartSample2(
                                    data: snapshot.data!.requests ?? [],
                                  );
                                }
                            }
                          }),
                      //chart line
                      StreamBuilder(
                          stream: homeViewModel.dataTimespentStream,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return skeletonChart();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return LineChartSample2(
                                    data: snapshot.data as List<double>,
                                  );
                                }
                            }
                          }),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: StreamBuilder(
                            stream: homeViewModel.projectsStream,
                            builder: (context,
                                AsyncSnapshot<List<Project>> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return skeletonListItem();
                                default:
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      borderOnForeground: true,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.blueAccent)),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Projects",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Column(
                                            children: snapshot.data!
                                                .map((val) =>
                                                    projectItemView(val))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              }
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: constantBottomNavigation(_selectedIndex),
      ),
    );
  }

  Widget carouselItem(Status item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TicketsPage(
                      title: item.statusName!,
                    )),
          );
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.blueAccent)),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Ticket type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.account_tree,
                        size: 25,
                        color: Color.fromRGBO(149, 170, 201, 1),
                      ),
                      Hero(
                        tag: "name_tickets",
                        child: Text(
                          item.statusName!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(149, 170, 201, 1.0),
                          ),
                        ),
                      ),
                      // const Icon(
                      //   Icons.account_tree,
                      //   size: 35,
                      //   color: Color.fromRGBO(149, 170, 201, 1),
                      // ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      "${item.quantity!.toInt()}",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget projectItemView(Project val) {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                val.image ?? "",
                scale: 16,
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    val.projectCode ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextScroll(
                      val.name ?? "",
                      intervalSpaces: 10,
                      mode: TextScrollMode.endless,
                      delayBefore: const Duration(milliseconds: 2000),
                      velocity: const Velocity(pixelsPerSecond: Offset(20, 30)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
