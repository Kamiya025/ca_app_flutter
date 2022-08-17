import 'dart:ffi';

import 'package:ca_app_flutter/src/model/data_type_request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const gridColor = Colors.transparent;
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

class RadarChartView extends StatefulWidget {
  const RadarChartView({Key? key, required this.dataTypeRequest}) : super(key: key);
  final DataTypeRequest dataTypeRequest;

  @override
  _RadarChartViewState createState() {
    return _RadarChartViewState();
  }
}

class _RadarChartViewState extends State<RadarChartView> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        AspectRatio(
          aspectRatio: 1.3,
          child: RadarChart(
            RadarChartData(
              dataSets: showingDataSets(),
              radarShape: RadarShape.polygon,
              radarBackgroundColor: const Color.fromRGBO(44, 123, 229, 0.1),
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(
                color: Color.fromRGBO(44, 123, 229, 0.5),
              ),
              titlePositionPercentageOffset: 0.08,
              titleTextStyle: const TextStyle(color: titleColor, fontSize: 10),
              getTitle: (index, angle) {
                final usedAngle =
                    relativeAngleMode ? angle + angleValue : angleValue;
                String title = widget.dataTypeRequest.titles[index];
                return RadarChartTitle(text: title, angle: usedAngle);
              },
              tickCount: 5,
              ticksTextStyle:
                  const TextStyle(color: Colors.transparent, fontSize: 10),
              tickBorderData: const BorderSide(
                color: Color.fromRGBO(44, 123, 229, 0.5),
                width: 0.5,
              ),
              gridBorderData: const BorderSide(
                color: Color.fromRGBO(44, 123, 229, 0.5),
                width: 0.8,
              ),
            ),
            swapAnimationDuration: const Duration(milliseconds: 2400),
          ),
        ),
      ],
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      var index = entry.key;
      var rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        borderColor: rawDataSet.color.withOpacity(0.5),
        entryRadius: 1,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        color: Colors.greenAccent,
        values: widget.dataTypeRequest.dataSet,
      ),
    ];
  }
}

class RawDataSet {
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.color,
    required this.values,
  });
}
