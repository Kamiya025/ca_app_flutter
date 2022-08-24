import 'package:ca_app_flutter/src/model/request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constant/constant_card_empty_data.dart';
import 'indicator.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({Key? key, required this.data}) : super(key: key);
  final List<Requests> data;

  @override
  State<StatefulWidget> createState() => PieChartState();

}

class PieChartState extends State<PieChartView> {
  int touchedIndex = -1;
  final colorList = [
    const Color(0xff0293ee),
    const Color(0xfff8b250),
    const Color(0xff845bef)
  ];

  @override
  Widget build(BuildContext context) {
    return
      cardData("Requests",child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 30,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  for(int i=0; i< widget.data.length;i++)
                    Indicator(
                      color: colorList[i],
                      text: widget.data[i].requestName!,
                      isSquare: true,
                    ),]

            ),

            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ));

  }

  List<PieChartSectionData> showingSections() {
    return List.generate(colorList.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: colorList[i],
        value: widget.data[i].quantity,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }

  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }
}
