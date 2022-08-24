import 'package:ca_app_flutter/src/constant/constant_bottom_navigation.dart';
import 'package:ca_app_flutter/src/constant/constant_card_empty_data.dart';
import 'package:ca_app_flutter/src/home/home_viewmodel.dart';
import 'package:ca_app_flutter/src/home/linechart_view.dart';
import 'package:ca_app_flutter/src/home/piechart_view.dart';
import 'package:ca_app_flutter/src/home/projects_view.dart';
import 'package:ca_app_flutter/src/home/radarchart_view.dart';
import 'package:ca_app_flutter/src/home/skeleton_home.dart';
import 'package:ca_app_flutter/src/model/all_tickets_status.dart';
import 'package:ca_app_flutter/src/model/request.dart';
import 'package:ca_app_flutter/src/model/status.dart';
import 'package:ca_app_flutter/src/util/calculator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:text_scroll/text_scroll.dart';
import '../Tickets/Tickets_view.dart';
import '../constant/request_type_color.dart';
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
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 20, left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Dashboard",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    List<Status> status =
                                        snapshot.data!.status!;
                                    // List<Status> status = List<Status>.from([]) ;

                                    return RadarChartView(
                                        dataTypeRequest: status.isEmpty
                                            ? DataTypeRequest(
                                                [], [1, 1, 1, 1, 1, 1])
                                            : DataTypeRequest.fromRequests(
                                                status),
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
                                    List<Status> status =
                                        snapshot.data!.status!;
                                    // List<Status> status = List<Status>.from([]) ;
                                    return status.isEmpty
                                        ? cardData("Ticket type")
                                        : Column(
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
                                                items: status
                                                    .map((item) =>
                                                        carouselItem(item))
                                                    .toList(),
                                              ),
                                            ],
                                          );
                                  }
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),

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
                                    var requests = snapshot.data!.requests;
                                    // var requests = List<Requests>.from([]);
                                    return requests!.isEmpty
                                        ? cardData("Requests")
                                        : PieChartView(
                                            data: requests,
                                          );
                                  }
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
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
                                    List<double> timespent =
                                        snapshot.data as List<double>;
                                    print("q:$timespent");
                                    return Calculator.sumListDouble(
                                                timespent) ==
                                            0
                                        ? cardData("Performance")
                                        : LineChartView(
                                            data: timespent,
                                          );
                                  }
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder(
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
                                    var data = snapshot.data;
                                    // var data = List<Project>.from([]);
                                    return data!.isEmpty
                                        ? cardData("Project")
                                        : cardData(
                                            "Project",
                                            child: Column(
                                              children: data
                                                  .map((val) =>
                                                      projectItemView(val))
                                                  .toList(),
                                            ),
                                          );
                                  }
                              }
                            }),
                      ],
                    ),
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketsPage(
                    title: item.statusName!,
                  )),
        );
      },
      child: cardData(
        "Ticket type",
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image(
                        image: RequestTypeColor.mapStatusImageIcon[
                                item.statusName ?? "OPEN_REQUEST"] ??
                            const AssetImage("assets/request.png"),
                      width: 30,
                      color: const Color.fromRGBO(149, 170, 201, 1.0),
                    ),
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
      ),
    );
  }
}
