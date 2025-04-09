import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_guardian/helper/graph_Formatter.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';

class BarChartExample extends StatefulWidget {
  const BarChartExample({super.key, required this.list});

  @override
  _BarChartExampleState createState() => _BarChartExampleState();
  final List<dynamic> list;
}

class _BarChartExampleState extends State<BarChartExample> {
  int? tappedGroupIndex; // To track which bar group is clicked
  double? tappedRodValue; // To store the value of the clicked rod

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: 1.053 * SizeConfig.heightMultiplier,
              bottom: 1.58 * SizeConfig.heightMultiplier,
              left: 1.11 * SizeConfig.widthMultiplier),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              BarChart(
                BarChartData(
                  barGroups: List.generate(
                      widget.list[0]["systolic"].length,
                      (index) => _buildBarGroup(
                          index,
                          widget.list[0]["systolic"][index].toDouble(),
                          widget.list[0]["diastolic"][index].toDouble(),lineChartFormatter[widget.list[0]["systolic"].length]!)),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() % 20 == 0) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 59, 56, 56),
                                fontFamily: "CoreSansBold",
                                fontSize: 1.68 * SizeConfig.heightMultiplier,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) {
                        return Colors.transparent;
                      },
                      tooltipPadding: EdgeInsets.zero,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                          null,
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          tappedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                          tappedRodValue =
                              response.spot!.touchedRodData.toY; // Get value
                        });
                      } else {
                        setState(() {
                          tappedGroupIndex = null;
                          tappedRodValue = null;
                        });
                      }
                    },
                  ),
                ),
              ),
              if (tappedRodValue != null)
                Positioned(
                  top: 21.06 * SizeConfig.heightMultiplier,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 3.16 * SizeConfig.heightMultiplier,
                    child: Text(
                      '${tappedRodValue!.toStringAsFixed(1)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 1.89 * SizeConfig.heightMultiplier),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y1, double y2,double width) {
    return BarChartGroupData(
      barsSpace: 8,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: width* SizeConfig.widthMultiplier,
          borderRadius: BorderRadius.circular(0.42134*SizeConfig.heightMultiplier),
          color: Colours.buttonColorRed,
        ),
        BarChartRodData(
          toY: y2,
          width: width * SizeConfig.widthMultiplier,
          borderRadius: BorderRadius.circular(0.42134*SizeConfig.heightMultiplier),
          color: Colors.red.withOpacity(0.2),
        ),
      ],
    );
  }
}


