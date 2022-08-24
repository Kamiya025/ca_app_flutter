import 'package:ca_app_flutter/src/util/calculator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constant/constant_card_empty_data.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({Key? key, required this.data}) : super(key: key);
  final List<double> data;

  @override
  LineChartViewState createState() => LineChartViewState();


}

class LineChartViewState extends State<LineChartView> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  List<FlSpot> _mainData = [];
  double _maxMainData = 0;
  @override
  void initState() {
    _mainData = widget.data.asMap().entries.map((entry) {
      int idx = entry.key;
      double val = entry.value;
      return FlSpot(idx.toDouble(), val);
    }).toList();
    _maxMainData = Calculator.maxFlSpot(_mainData);
  }


  @override
  Widget build(BuildContext context) {
    return
      cardData("Performance", child:Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.70,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 12.0, top: 24, bottom: 12),
                        child: LineChart(mainData(),
                          swapAnimationDuration: const Duration(milliseconds: 1150),
                          swapAnimationCurve: Curves.easeInBack,
                        ),
                      ),
                    ),
                  ],
                ),
      );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    text = Text("${(value+1).toInt()}");
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {

    const style = TextStyle(fontSize: 10);


    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toInt().toString(),
        style: style,
      ),
    );

  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            interval: _maxMainData/5,
            reservedSize: 46,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: _mainData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }


}
