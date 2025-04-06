import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';

class CustomLineChart extends StatelessWidget {
  final List<dynamic> list;

  const CustomLineChart({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: 5.79 * SizeConfig.heightMultiplier,
            right: 4.46 * SizeConfig.widthMultiplier,
            left: 2.23 * SizeConfig.widthMultiplier),
        child: Center(
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.white,
              minX: 1,
              maxX: 6,
              minY: 40,
              maxY: 140,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 3.68 * SizeConfig.heightMultiplier,
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 59, 56, 56),
                            fontFamily: "CoreSansBold",
                            fontSize: 1.68 * SizeConfig.heightMultiplier),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 4.74 * SizeConfig.heightMultiplier,
                    showTitles: true,
                    interval: 20,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 59, 56, 56),
                            fontFamily: "CoreSansBold",
                            fontSize: 1.68 * SizeConfig.heightMultiplier),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Hide top titles
                ),
                rightTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false), // Hide right titles
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(list[0]["sugar_level"].length,(index){
                    return FlSpot(((index+1).toDouble()),list[0]["sugar_level"][index]);
                  }),
                  isCurved: false,
                  color: Colours.buttonColorRed,
                  barWidth: 0.78 * SizeConfig.widthMultiplier,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.red.withOpacity(0.2),
                  ),
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 0.68 * SizeConfig.heightMultiplier,
                      color: Colors.white,
                      strokeWidth: 3,
                      strokeColor: Colours.buttonColorRed,
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) {
                    return Color.fromARGB(255, 11, 10, 10);
                  },

                  tooltipRoundedRadius: 3.16 *
                      SizeConfig
                          .heightMultiplier, // Rounded radius to make it circular
                  tooltipPadding: EdgeInsets.all(0.84*SizeConfig.heightMultiplier),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        spot.y.toInt().toString(),
                         TextStyle(
                          color: Colours.buttonColorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.68*SizeConfig.heightMultiplier,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
