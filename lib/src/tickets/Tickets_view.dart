
import 'package:ca_app_flutter/src/tickets/tickets_viewmodel.dart';
import 'package:ca_app_flutter/src/model/all_tickets_status.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ca_app_flutter/src/tickets/skeleton_tickets.dart';
import '../constant/constamt_backgrond.dart';
import '../constant/request_type_color.dart';
import '../model/detail.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  TicketsViewModel ticketsViewModel = TicketsViewModel();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      ticketsViewModel = TicketsViewModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: constantbgImage(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          toolbarHeight: 70,
          title: Hero(
              tag: "name_tickets",
              child: Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              )),
          actions: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                  stream: ticketsViewModel.allTicketsStatusStream,
                  builder: (context, AsyncSnapshot<AllTicketsStatus> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return skeletonTicketsItem();
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var listDeteils = snapshot.data?.tickets!
                              .firstWhere(
                                  (element) => element.type == widget.title)
                              .details;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                listDeteils!.map((e) => ticketItem(e)).toList(),
                          );
                        }
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketItem(Details e) {
    var bgAvatarCustomer = colorFromString(e.customerName!);
    return Card(
      borderOnForeground: true,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.issueKey ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: bgAvatarCustomer,
                    maxRadius: 15,
                    child: Text(
                      e.customerName!.substring(0, 1),
                    ),
                  ),
                ),
                Text(e.customerName ?? ""),
              ],
            ),
            Container(
              height: 80,
              alignment: Alignment.centerLeft,
              child: Text(e.summary ?? ""),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: CircleAvatar(
                        backgroundColor: RequestTypeColor.mapRequestTypeColor[e.requestTypeName!]??const Color(0xfffbfcfb),
                        maxRadius: 5,
                      ),
                    ),
                    Text(e.requestTypeName ?? ""),
                  ],
                ),
                Text("Due ${Jiffy(e.resolvedDate ?? "").fromNow()}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Color colorFromString(String str) {
    var hash = 88430;
    for (var i = 0; i < str.length; i++) {
      hash = str.toUpperCase().codeUnitAt(i) + ((hash << 8) + hash);
    }
    return Color(hash);
  }
}
