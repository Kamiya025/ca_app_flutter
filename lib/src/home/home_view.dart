import 'package:ca_app_flutter/src/home/home_viewmodel.dart';
import 'package:ca_app_flutter/src/home/linechart_view.dart';
import 'package:ca_app_flutter/src/home/piechart_view.dart';
import 'package:ca_app_flutter/src/home/radarchart_view.dart';
import 'package:ca_app_flutter/src/model/allT_tckets_status.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../model/data_type_request.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CarouselController buttonCarouselController = CarouselController();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void dispose() {
    homeViewModel.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromRGBO(186, 201, 252, 1.0),
          Colors.blue,
          Colors.red,
        ],
      )),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Image(
            image: AssetImage("assets/fpt_logo.png"),
            width: 75,
          ),
          titleSpacing: 30,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Dashboard",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: StreamBuilder(
                      stream: homeViewModel.allTicketsStatusStream,
                      builder: (context,AsyncSnapshot<AllTicketsStatus>  snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                                child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return RadarChartView(
                                  dataTypeRequest:
                                      DataTypeRequest.fromRequests(snapshot.data!.status!),
                                  callBack: (i) {
                                    if (i >= 0) {
                                      buttonCarouselController.animateToPage(i);
                                    }
                                  });
                            }
                        }
                      }),
                ),
                Column(
                  children: [
                   StreamBuilder(
                        stream: homeViewModel.allTicketsStatusStream,
                        builder: (context, AsyncSnapshot<AllTicketsStatus> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      CarouselSlider(
                                        carouselController:
                                            buttonCarouselController,
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          height: 100,
                                          disableCenter: false,
                                          pageSnapping: true,
                                        ),
                                        items: snapshot.data!.status!
                                            .map(
                                              (item) => Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Container(
                                                  // width: 600,
                                                  padding:
                                                      const EdgeInsets.all(18),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item.statusName!,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Color.fromRGBO(149, 170, 201, 1.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            child: Text(
                                                              "${item.quantity!.toInt()}",
                                                              style: const TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Icon(
                                                        Icons.account_tree,
                                                        size: 35,
                                                        color: Color.fromRGBO(
                                                            149, 170, 201, 1),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }
                        }),
                    StreamBuilder(
                        stream: homeViewModel.allTicketsStatusStream,
                        builder: (context,
                            AsyncSnapshot<AllTicketsStatus> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
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
                    StreamBuilder(
                        stream: homeViewModel.dataTimespentStream,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
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
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          elevation: 15,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
