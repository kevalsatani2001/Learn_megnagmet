import 'package:dashboard_app/controller/controller.dart';
import 'package:dashboard_app/helpers/icons_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class Graph extends StatefulWidget {
  var incomeprice;
  var expenceprice;

   Graph(double totalIncome, double totalExpence, {Key? key,required this.incomeprice,required this.expenceprice}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  var dbHelper = DataBase();

  final Color income = const Color(0XFF4CB04F);
  final Color expence = const Color(0XFFF34334);

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Color(0xff939393), fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sup';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Des';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      child: Text(text, style: style),
      axisSide: meta.axisSide,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
        color: Color(
          0xff738593,
        ),
        fontSize: 13,
        fontWeight: FontWeight.w700);
    return SideTitleWidget(
      child: Text(
        meta.formattedValue,
        style: style,
      ),
      axisSide: meta.axisSide,
    );
  }
StatisticsScreenController statisticsScreenController = Get.put(StatisticsScreenController());
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(

          padding: const EdgeInsets.only(top: 16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: leftTitles,
                  ),

                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),

                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false,),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 10 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  strokeWidth: 0,
                ),
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              groupsSpace: 20,
              barGroups: getData(),

            ),
          )),
    );
  }

  List<BarChartGroupData> getData() {
    return [

      for (var i = 8; i < 9; i++)
        BarChartGroupData(
          x: i,
          barsSpace: 4,
          barRods: [
            BarChartRodData(
                toY: widget.incomeprice,
                width: 35,
                rodStackItems: [
                  BarChartRodStackItem(
                    0,
                    widget.incomeprice,
                    income,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            BarChartRodData(
                toY: widget.expenceprice,
                width: 35,
                rodStackItems: [
                  BarChartRodStackItem(0, widget.expenceprice, expence),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          ],
        ),
    ];
  }
}
