import 'package:fl_chart/fl_chart.dart';

class Calculator{
static int averagesListFlSpot(List<FlSpot> data)
{
  return (data.fold<double>(0, (double sum, item) => (sum + item.y)))~/data.length;
}
static double maxFlSpot(List<FlSpot> data)
{
  return (data.fold<double>(0, (double max, item) => (item.y>max?item.y:max)));
}
static double sumListDouble(List<double> data)
{
  return (data.fold<double>(0, (double sum, item) => (sum + item)));
}

}