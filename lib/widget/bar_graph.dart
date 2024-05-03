import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  const BarGraph(
      {super.key, required this.actualCrowd, required this.predictedCrowd});
  final List<double> predictedCrowd;
  final List<double> actualCrowd;
  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  String selectedValue = 'Predicted Crowding Level';
  List<double> graphValue = [];
  @override
  void initState() {
    graphValue = widget.actualCrowd;
    super.initState();
  }

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
      height: MediaQuery.of(context).size.height * 0.6,
      // color: Color.fromARGB(255, 255, 232, 231),
      child: Column(
        children: [
          //
          //DAY ANALYTICS text and dropdown list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                const Text(
                  'DAY ANALYTICS',
                  style: TextStyle(
                    color: Color.fromARGB(255, 85, 85, 85),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                //dropdown
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    value: selectedValue,
                    items: <String>[
                      'Actual Crowd Registered',
                      'Predicted Crowding Level'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue == null) {
                        return;
                      }
                      setState(() {
                        selectedValue = newValue;
                        if (newValue == 'Actual Crowd Registered') {
                          graphValue = widget.actualCrowd;
                        } else {
                          graphValue = widget.predictedCrowd;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.height * 0.6,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 25),

          //bargraph
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.49,
              // width: 400,
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    horizontalInterval: 25,
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              '${value.toInt()} hrs',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ))),
                  barGroups: graphValue
                      .asMap()
                      .entries
                      .map(
                        (data) => BarChartGroupData(
                          x: data.key,
                          barRods: [
                            BarChartRodData(
                              toY: data.value * 4,
                              color: const Color.fromARGB(126, 158, 158, 158),
                              width:
                                  (MediaQuery.of(context).size.width - 33) / 24,
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
