import 'package:ca_app_flutter/src/model/data_type_request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const gridColor = Colors.white;
const titleColor = Colors.white;

class RadarChartView extends StatefulWidget {
  const RadarChartView(
      {Key? key, required this.dataTypeRequest, required this.callBack})
      : super(key: key);
  final DataTypeRequest dataTypeRequest;
  final Function(int i) callBack;

  @override
  State<StatefulWidget> createState() {
    return _RadarChartViewState();
  }
}

class _RadarChartViewState extends State<RadarChartView> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;
  List<double> data = [0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.3,
          child: RadarChart(
            RadarChartData(
              radarTouchData:
                  RadarTouchData(touchCallback: (FlTouchEvent event, response) {
                widget.callBack(
                    response?.touchedSpot?.touchedRadarEntryIndex ?? -1);
              }),
              dataSets: showingDataSets(),
              radarShape: RadarShape.circle,
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(
                color: gridColor,
                width: 2,
              ),
              titlePositionPercentageOffset: 0.08,
              titleTextStyle: const TextStyle(color: titleColor, fontSize: 10),
              getTitle: (index, angle) {
                String title = widget.dataTypeRequest.titles[index];
                return RadarChartTitle(
                    text: title, angle: (angle == 180) ? 0 : angle);
              },
              tickCount: 3,
              ticksTextStyle:
                  const TextStyle(color: Colors.transparent, fontSize: 10),
              tickBorderData: const BorderSide(
                color: gridColor,
                width: 0.2,
              ),
              gridBorderData: const BorderSide(
                color: gridColor,
                width: 1,
              ),
            ),
            swapAnimationDuration: const Duration(milliseconds: 2400),
            swapAnimationCurve: Curves.bounceOut,
          ),
        ),
      ),
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
        borderColor: rawDataSet.color.withOpacity(0.9),
        entryRadius: 1,
        fillColor: const Color.fromRGBO(149, 252, 73, .3),
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        color: const Color.fromRGBO(149, 252, 73, 1.0),
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
