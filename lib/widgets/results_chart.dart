import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// #ee4035 • #f37736 • #fdf498 • #7bc043 • #0392cf​
const List<Color> colorsChart = [
  Color(0xffee4035),
  Color(0xfff37736),
  Color(0xfffdf498),
  Color(0xff7bc043),
  Color(0xff0392cf),
];

class ResultsChart extends StatefulWidget {

  final String model;
  final Map<String, dynamic> result;

  const ResultsChart({Key key, this.model, this.result}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ResultsChartState();
}

class ResultsChartState extends State<ResultsChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .05,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData: PieTouchData(
                        touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 45,
                    sections: showingSections()),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              //#96ceb4 • #ffeead • #ff6f69 • #ffcc5c • #88d8b0​
              Indicator(
                color: Color(0xffee4035),
                text: 'ArtDecor',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xfff37736),
                text: 'Hitech',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xfffdf498),
                text: 'Indochina',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xff7bc043),
                text: 'Industrial',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xff0392cf),
                text: 'Scandinavian',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 16 : 12;
      final double radius = isTouched ? 55 : 50;
      return PieChartSectionData(
        color: colorsChart[i],
        value: widget.result[widget.model][i],
        title: (widget.result[widget.model][i] >= 5) ? '${widget.result[widget.model][i]}%' : '',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      );
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff96ceb4),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
        //#96ceb4 • #ffeead • #ff6f69 • #ffcc5c • #88d8b0​
          return PieChartSectionData(
            color: const Color(0xffffeead),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffff6f69),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xffffcc5c),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xff88d8b0),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: textColor),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}